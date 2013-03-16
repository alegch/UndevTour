//
//  UTMapViewController.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTMapViewController.h"
#import "UTExhibitDetailViewController.h"
#import "UTLevelView.h"

#import "UTHouseBuilder.h"
#import "UTHouse.h"
#import "UTLevel.h"
#import "UTExhibit.h"
#import "UTPathFinderModel.h"
#import "UTBlockService.h"
#import "UTLevelsPanel.h"
#import "IntPoint.h"

#import <ZBarSDK/ZBarSDK.h>

@interface UTMapViewController () <UTLevelsPanelDelegate,
                                   UTLevelViewDelegate,
                                   ZBarReaderDelegate>
{
    UTHouse *_house;

    NSInteger _selectedLevelIndex;
    UTLevelView *_selectedLevelView;
    UTLevelsPanel *_panel;
    NSMutableArray *_levelsViews;
}

@end

@implementation UTMapViewController

#pragma mark - Life Cycle
- (id)init {
    self = [super init];
    if (self) {
        UTHouseBuilder *builder = [[UTHouseBuilder alloc] init];
        _house = [builder buildHouseWithName:@"undev"];
        _levelsViews = [NSMutableArray array];
        _selectedLevelIndex = NSNotFound;
        
        self.title = @"Undev Toure";
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    UIButton *checkinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *checkinImage = [UIImage imageNamed:@"checkinIcon.png"];
    checkinButton.frame = CGRectMake(0.0f, 0.0f, checkinImage.size.width, checkinImage.size.height);
    [checkinButton setImage:checkinImage forState:UIControlStateNormal];
    [checkinButton setImage:[UIImage imageNamed:@"checkinIcon-selected.png"] forState:UIControlStateHighlighted];
    [checkinButton addTarget:self action:@selector(checkinButtonHendler) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:checkinButton];
    
    UIButton *makeToureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *makeToureImage = [UIImage imageNamed:@"MakeToure.png"];
    makeToureButton.frame = CGRectMake(0.0f, 0.0f, makeToureImage.size.width, makeToureImage.size.height);
    [makeToureButton setImage:makeToureImage forState:UIControlStateNormal];
    [makeToureButton setImage:[UIImage imageNamed:@"MakeToure-selected.png"] forState:UIControlStateHighlighted];
    [makeToureButton addTarget:self action:@selector(makeToureButtonHendler) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:makeToureButton];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    
    for (UTLevel *level in [_house sortedByZOrderLevelByAscending:YES]) {
        UTLevelView *levelView = [[UTLevelView alloc] initWithFrame:CGRectZero];
        levelView.exhibitDelegate = self;
        [levelView setLevel:level];
        [_levelsViews addObject:levelView];
    }
    
    [self setSelectedLevelViewIndex:0];
    
    _panel = [[UTLevelsPanel alloc] initWithFrame:CGRectMake(0, 0, 320, 44) count:_house.levels.count];
    _panel.panelDelegate = self;
    [self.view addSubview:_panel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    for (UIView *v in _levelsViews) {
        v.frame = self.view.bounds;
    }
    _panel.frame = RectSetOrigin(_panel.frame, 0, self.view.bounds.size.height - _panel.frame.size.height);
}

#pragma mark - buttons hendlers

- (void)checkinButtonHendler
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    
    UIImageView *overlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_overlay.png"]];
    
    reader.cameraOverlayView = overlay;
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
    [scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:1];
    reader.readerView.zoom = 1.0;
    
    [self presentModalViewController: reader
                            animated: YES];
}

- (void)makeToureButtonHendler
{
    NSMutableArray * items = [NSMutableArray array];
    for (UTExhibit *exhibit in [_house.levels[_selectedLevelIndex] exhibits]) {
        [items addObject:[[KNSelectorItem alloc] initWithDisplayValue:exhibit.name
                                                          selectValue:exhibit.name
                                                                image:[UIImage imageNamed:exhibit.photoPath]]];
    }
    
    KNMultiItemSelector * selector = [[KNMultiItemSelector alloc] initWithItems:items delegate:self];
    UINavigationController * uinav = [[UINavigationController alloc] initWithRootViewController:selector];
    uinav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; // iPhone
    
    [self presentModalViewController:uinav animated:YES];
}

#pragma mark - Methods
- (void)setSelectedLevelViewIndex:(NSInteger)index {
    NSAssert(index < [_levelsViews count], @"Level view index out of range");
    if (_selectedLevelView) {
        [_selectedLevelView removeFromSuperview];
    }
    
    UTLevelView *levelView = [_levelsViews objectAtIndex:index];
    [self.view addSubview:levelView];
    [self.view sendSubviewToBack:levelView];
    _selectedLevelView = levelView;
    _selectedLevelIndex = index;
}

- (void)setCurrentPositionToExhibit:(UTExhibit *)exhibit {
    NSInteger exhibitLevelIndex = [_house levelIndexByExhibit:exhibit];
    NSLog(@"set exibit index: %d", exhibitLevelIndex);
    [self setSelectedLevelViewIndex:exhibitLevelIndex];
    [_selectedLevelView setCenterToExhibit:exhibit];
    [_panel setSelectedIndex:exhibitLevelIndex];
}

#pragma mark - UILevelsPanel Delegate
- (void)onSelectLevelWithIndex:(NSInteger)index {
    [self setSelectedLevelViewIndex:index];
}

#pragma mark - KNMultiItemSelector Delegate

-(void)selectorDidCancelSelection
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)selectorDidFinishSelectionWithItems:(NSArray*)selectedItems
{
    [self dismissModalViewControllerAnimated:YES];
    
    UTLevel *level = _house.levels[0];

    UTBlockService *blockService = [[UTBlockService alloc] initWithBlocks:level.map];
    UTPathFinderModel *model = [[UTPathFinderModel alloc] initWithBlockService:blockService];

    NSMutableArray *exhibits = [NSMutableArray arrayWithArray:level.exhibits];
    UTExhibit *strtExhibit = [exhibits lastObject];
    [exhibits removeObject:strtExhibit];

    NSArray *path = [model findPathForObjects:exhibits startOn:strtExhibit];
    
    NSMutableArray *pathWhisLines = [NSMutableArray arrayWithCapacity:path.count];
    for (NSArray *subPath in path) {
        NSMutableArray *lines = [NSMutableArray array];
        [pathWhisLines addObject:lines];
        
        IntPoint *startPoint = nil;
        IntPoint *prevPoint = nil;
        IntPoint *diff = nil;
        for (IntPoint *point in subPath) {
            if (!startPoint) {
                startPoint = point;
            }
            if (prevPoint != nil) {
                IntPoint *newDiff = [IntPoint pointWithX:point.x - prevPoint.x withY:point.y - prevPoint.y];
                if (diff && (diff.x != newDiff.x || diff.y != newDiff.y)) {
                    [lines addObject:@{@"start": startPoint, @"end": prevPoint}];
                    startPoint = prevPoint;
                }
                else if([subPath indexOfObject:point] == subPath.count - 1) {
                    [lines addObject:@{@"start": startPoint, @"end": point}];
                }
                diff = newDiff;
            }
            prevPoint = point;
        }
    }
    
    [_selectedLevelView showPath:pathWhisLines];
}

#pragma mark - QR-reader delegate 
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    NSString *hash = symbol.data;
    NSLog(@"Hash:%@", hash);
    UTExhibit *ex = [_house exibitByHashCode:hash];
    [self setCurrentPositionToExhibit:ex];

    [reader dismissModalViewControllerAnimated: YES];
}

#pragma mark - UTLevelViewDelegate
- (void)onExhibitTapped:(UTExhibit *)exhibit inLevelView:(UTLevelView *)levelView {
    UTExhibitDetailViewController *vc = [[UTExhibitDetailViewController alloc] init];
    [vc setExhibit:exhibit];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

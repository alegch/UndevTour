//
//  UTMapViewController.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTMapViewController.h"
#import "UTLevelView.h"

#import "UTHouseBuilder.h"
#import "UTHouse.h"
#import "UTLevel.h"
<<<<<<< HEAD
=======
#import "UTExhibit.h"
#import "UTPathFinderModel.h"
#import "UTBlockService.h"
>>>>>>> f98a82deee751203a1853b107dbd34c26d45c1cc

@interface UTMapViewController () {
    UTHouse *_house;

    UTLevelView *_selectedLevel;
    NSMutableArray *_levelsViews;
}

@end

@implementation UTMapViewController

#pragma mark - Life Cycle
- (id)init {
    self = [super init];
    if (self) {
<<<<<<< HEAD
        UTHouseBuilder *builder = [[UTHouseBuilder alloc] init];
        _house = [builder buildHouseWithName:@"undev"];
        _levelsViews = [NSMutableArray array];
=======
        _builder = [[UTHouseBuilder alloc] init];
        _house = [_builder buildHouseWithName:@"undev"];

        UTLevel *level = _house.levels[0];

        UTBlockService *blockService = [[UTBlockService alloc] initWithBlocks:level.map];
        UTPathFinderModel *model = [[UTPathFinderModel alloc] initWithBlockService:blockService];
        
        NSMutableArray *exhibits = [NSMutableArray arrayWithArray:level.exhibits];
        UTExhibit *strtExhibit = [exhibits lastObject];
        [exhibits removeObject:strtExhibit];
        
        [model findPathForObjects:exhibits startOn:strtExhibit];
>>>>>>> f98a82deee751203a1853b107dbd34c26d45c1cc
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    
    for (UTLevel *level in [_house sortedByZOrderLevelByAscending:YES]) {
        UTLevelView *levelView = [[UTLevelView alloc] initWithFrame:CGRectZero];
        [levelView setLevel:level];
        [_levelsViews addObject:levelView];
    }

    [self setSelectedLevelViewIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    for (UIView *v in _levelsViews) {
        v.frame = self.view.bounds;
    }
}

#pragma mark - Methods
- (void)setSelectedLevelViewIndex:(NSInteger)index {
    NSAssert(index < [_levelsViews count], @"Level view index out of range");
    if (_selectedLevel) {
        [_selectedLevel removeFromSuperview];
    }
    
    UTLevelView *levelView = [_levelsViews objectAtIndex:index];
    [self.view addSubview:levelView];
}

@end

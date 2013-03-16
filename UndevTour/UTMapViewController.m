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
        UTHouseBuilder *builder = [[UTHouseBuilder alloc] init];
        _house = [builder buildHouseWithName:@"undev"];
        _levelsViews = [NSMutableArray array];
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

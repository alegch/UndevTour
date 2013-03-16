//
//  UTMapViewController.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTMapViewController.h"
#import "UTHouseBuilder.h"
#import "UTHouse.h"

@interface UTMapViewController () {
    UTHouseBuilder *_builder;
    UTHouse *_house;
}

@end

@implementation UTMapViewController

#pragma mark - Life Cycle
- (id)init {
    self = [super init];
    if (self) {
        _builder = [[UTHouseBuilder alloc] init];
        _house = [_builder buildHouseWithName:@"undev"];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end

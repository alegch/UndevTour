//
//  UTHouse.h
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTHouse : NSObject

#pragma mark - Properties
@property (nonatomic, strong) NSArray *levels;

#pragma mark - Methods
- (NSArray *)sortedByZOrderLevelByAscending:(BOOL)ascending;

@end

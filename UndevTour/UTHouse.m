//
//  UTHouse.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTHouse.h"

@implementation UTHouse

- (NSArray *)sortedByZOrderLevelByAscending:(BOOL)ascending {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"z" ascending:ascending];
    NSArray *sortedLevels = [self.levels sortedArrayUsingDescriptors:@[descriptor]];
    return sortedLevels;
}

@end

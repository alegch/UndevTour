//
//  NSArray+reverseArray.m
//  UndevTour
//
//  Created by Иван Ушаков on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "NSArray+reverseArray.h"

@implementation NSArray (reverseArray)

- (NSArray*)reverseArray
{
    NSMutableArray *reversedArray = [NSMutableArray arrayWithCapacity:self.count];
    [reversedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [reversedArray addObject:obj];
    }];
    return [NSArray arrayWithArray:reversedArray];
}

@end

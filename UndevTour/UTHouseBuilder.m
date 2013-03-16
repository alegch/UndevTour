//
//  UTHouseBuilder.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTHouseBuilder.h"
#import "UTLevelBulder.h"

#import "UTLevel.h"
#import "UTHouse.h"

@implementation UTHouseBuilder

- (UTHouse *)buildHouseWithName:(NSString *)name {
    NSArray *levelsDicts = [NSArray arrayWithContentsOfFile:name];
    NSAssert(levelsDicts, [NSString stringWithFormat:@"Resources for house do not exist"]);
    
//    UTLevelBulder *levelBuilder = [[UTLevelBulder alloc] init];
//    for (NSDictionary *levelDict in levelsDicts) {
//    }
    return nil;
    
}

@end

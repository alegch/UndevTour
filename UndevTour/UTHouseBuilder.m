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
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError * error=nil;
    NSArray * levelsDicts = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSAssert(levelsDicts, [NSString stringWithFormat:@"Resources for house do not exist"]);
    
    UTHouse *house = [[UTHouse alloc] init];
    
    NSMutableArray *levels = [NSMutableArray array];
    UTLevelBulder *levelBuilder = [[UTLevelBulder alloc] init];
    
    for (NSDictionary *levelDict in levelsDicts) {
        UTLevel *lvl = [levelBuilder buildLevelFromDictionary:levelDict];
        [levels addObject:lvl];
    }
    house.levels = levels;

    return house;
}

@end

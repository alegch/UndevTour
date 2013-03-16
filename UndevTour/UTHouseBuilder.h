//
//  UTHouseBuilder.h
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UTHouse;

@interface UTHouseBuilder : NSObject

#pragma mark - Methods
- (UTHouse *)buildHouseWithName:(NSString *)name;

@end

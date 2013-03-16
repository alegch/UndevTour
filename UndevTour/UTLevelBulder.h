//
//  UTLevelBulder.h
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UTLevel;

@interface UTLevelBulder : NSObject

#pragma mark - Methods
- (UTLevel *)buildLevelFromDictionary:(NSDictionary *)dictionary;

@end

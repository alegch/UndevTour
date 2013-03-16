//
//  UTLevel.h
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTLevel : NSObject

#pragma mark - Properties
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSNumber *z;
@property (nonatomic, strong) NSArray *map;
@property (nonatomic, strong) NSArray *exhibits;


@end

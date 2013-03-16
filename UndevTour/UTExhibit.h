//
//  UTExhibit.h
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTExhibit : NSObject

#pragma mark - Properties
@property (nonatomic, strong) NSString *iconPath;
@property (nonatomic, strong) NSString *selectedIconPath;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *definition;
@property (nonatomic, strong) NSString *photoPath;
@property (nonatomic, strong) NSValue *coordinate;
@property (nonatomic, strong) NSString *hash;

@end

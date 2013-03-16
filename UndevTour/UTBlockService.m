//
//  UTBlockService.m
//  UndevTour
//
//  Created by Иван Ушаков on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTBlockService.h"

@interface UTBlockService ()
@property (nonatomic, strong) NSMutableArray *blocks;
@end

@implementation UTBlockService


- (BOOL)isBlock:(int)x :(int)y
{
    return [self.blocks[x][y] boolValue];
}

@end

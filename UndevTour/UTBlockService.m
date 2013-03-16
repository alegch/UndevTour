//
//  UTBlockService.m
//  UndevTour
//
//  Created by Иван Ушаков on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTBlockService.h"

@implementation UTBlockService

- (id)initWithWidth:(int)width height:(int)height blocks:(NSArray*)blocks
{
    self = [super init];
    if (self) {
        self.width = width;
        self.height = height;
        self.blocks = blocks;
    }
    return self;
}


- (BOOL)isBlock:(int)x :(int)y
{
    return [self.blocks[x][y] boolValue];
}

@end

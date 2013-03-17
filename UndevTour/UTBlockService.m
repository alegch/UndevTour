//
//  UTBlockService.m
//  UndevTour
//
//  Created by Иван Ушаков on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTBlockService.h"

@implementation UTBlockService

- (id)initWithBlocks:(NSArray*)blocks
{
    self = [super init];
    if (self) {
        self.width = [blocks[0] count];
        self.height = blocks.count;
        self.blocks = blocks;
    }
    return self;
}


- (BOOL)isBlock:(int)x :(int)y
{
    return [self.blocks[y][x] boolValue];
}

@end

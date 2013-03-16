//
//  UTBlockService.h
//  UndevTour
//
//  Created by Иван Ушаков on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockService.h"

@interface UTBlockService : NSObject <BlockService>
@property int width;
@property int height;
@property (nonatomic, strong) NSArray *blocks;

- (id)initWithWidth:(int)width height:(int)height blocks:(NSArray*)blocks;
- (BOOL)isBlock:(int)x :(int)y;

@end

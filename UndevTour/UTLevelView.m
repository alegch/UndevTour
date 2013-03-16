//
//  UTLevelView.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTLevelView.h"
#import "UTLevel.h"

@implementation UTLevelView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)setLevel:(UTLevel *)level {
    UIImage *mapImage = [UIImage imageNamed:level.imagePath];
    UIImageView *mapImageView = [[UIImageView alloc] initWithImage:mapImage];
    [self addSubview:mapImageView];
    self.contentSize = mapImage.size;
    
}

@end

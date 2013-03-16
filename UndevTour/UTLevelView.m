//
//  UTLevelView.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTLevelView.h"
#import "UTLevel.h"
#import "UTExhibit.h"

@implementation UTLevelView
{
    UIView *_container;
    UIView *_iconsLayer;
    UIView *_pathLayer;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = YES;
        self.backgroundColor = [UIColor darkGrayColor];
        self.delegate = self;
    }
    return self;
}

- (void)setLevel:(UTLevel *)level {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _container = [[UIView alloc] init];
    [self addSubview:_container];

    UIImage *mapImage = [UIImage imageNamed:level.imagePath];
    UIImageView *mapImageView = [[UIImageView alloc] initWithImage:mapImage];
    [_container addSubview:mapImageView];

    _container.frame = RectSetSize(_container.frame, mapImage.size.width, mapImage.size.height);
    self.contentSize = mapImage.size;
    self.maximumZoomScale = 1.0f;
    self.minimumZoomScale = 320.0f / mapImage.size.width;
    
    _pathLayer = [[UIView alloc] init];
    [_container addSubview:_pathLayer];
    
    _iconsLayer = [[UIView alloc] init];
    [_container addSubview:_iconsLayer];
    
    for (UTExhibit *exhibit in level.exhibits) {
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:exhibit.iconPath]];
        icon.frame = RectSetOrigin(icon.frame, [exhibit.coordinate CGPointValue].x, [exhibit.coordinate CGPointValue].y);
        [_iconsLayer addSubview:icon];
    }
}

- (void)setCenterToExhibit:(UTExhibit*)exhibit
{
    CGRect visibleRect = CGRectMake(([exhibit.coordinate CGPointValue].x - self.frame.size.width / 2.0f) * self.zoomScale,
                                    ([exhibit.coordinate CGPointValue].y - self.frame.size.height / 2.0f)  * self.zoomScale,
                                    self.frame.size.width,
                                    self.frame.size.height);
    [self scrollRectToVisible:visibleRect animated:YES];
}

#pragma marl - scroll view delegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _container;
}

@end

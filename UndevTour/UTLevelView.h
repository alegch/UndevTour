//
//  UTLevelView.h
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UTLevel;
@class UTExhibit;

@interface UTLevelView : UIScrollView <UIScrollViewDelegate>

- (void)setLevel:(UTLevel *)level;
- (void)setCenterToExhibit:(UTExhibit*)exhibit;
- (void)showPath:(NSArray*)path;

@end


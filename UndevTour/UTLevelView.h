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

@protocol UTLevelViewDelegate;

@interface UTLevelView : UIScrollView <UIScrollViewDelegate>

#pragma mark - Properties
@property (nonatomic, strong) id<UTLevelViewDelegate> exhibitDelegate;

#pragma mark - Methods
- (void)setLevel:(UTLevel *)level;
- (void)setCenterToExhibit:(UTExhibit*)exhibit;
- (void)showPath:(NSArray*)path;

@end

@protocol UTLevelViewDelegate
- (void)onExhibitTapped:(UTExhibit *)exhibit inLevelView:(UTLevelView *)levelView;
@end


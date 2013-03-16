//
//  UTLevelsPanel.h
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UTLevelsPanelDelegate;

@interface UTLevelsPanel : UIScrollView {
    NSMutableArray *_butons;
    NSInteger _selectedIndex;
}

#pragma mark - Properties
@property (nonatomic, weak) id<UTLevelsPanelDelegate> panelDelegate;

#pragma mark - Methods
- (id)initWithFrame:(CGRect)frame count:(NSInteger)count;
- (void)setSelectedIndex:(NSInteger)index;

@end

@protocol UTLevelsPanelDelegate
- (void)onSelectLevelWithIndex:(NSInteger)index;
@end


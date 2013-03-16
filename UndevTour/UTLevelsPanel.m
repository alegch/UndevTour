//
//  UTLevelsPanel.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTLevelsPanel.h"

@implementation UTLevelsPanel

- (id)initWithFrame:(CGRect)frame count:(NSInteger)count {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.scrollEnabled = YES;
        _butons = [NSMutableArray array];
        _selectedIndex = NSNotFound;
        
        CGFloat yOffset = 0.0f;
        for (int i = 0; i < count; i++) {
            UIButton *lvlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [lvlBtn setFrame:CGRectMake(0, yOffset, 44, 44)];
            [lvlBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [lvlBtn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [lvlBtn addTarget:self action:@selector(onLevelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:lvlBtn];
            [_butons addObject:lvlBtn];
            
            yOffset += 44;
        }
        
        self.contentSize = CGSizeMake(RectWidth(self.frame), yOffset);
        [self setSelectedIndex:0];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)index {
    NSAssert(index < [_butons count], @"Index out of range");
    
    if (_selectedIndex != NSNotFound) {
        UIButton *selectedBtn = [_butons objectAtIndex:_selectedIndex];
        [selectedBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    
    _selectedIndex = index;
    UIButton *newSelectedBtn = [_butons objectAtIndex:_selectedIndex];
    [newSelectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - Event Handlers
- (void)onLevelButtonTapped:(id)sender {
    NSInteger index = [_butons indexOfObject:sender];
    [self setSelectedIndex:index];
    
    [self.panelDelegate onSelectLevelWithIndex:index];
}

@end

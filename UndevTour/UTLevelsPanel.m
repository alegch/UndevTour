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
        
        CGFloat xOffset = 0.0f;
        for (int i = 0; i < count; i++) {
            UIButton *lvlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [lvlBtn setFrame:CGRectMake(xOffset, 0, 44, 44)];
            [lvlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lvlBtn setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [lvlBtn addTarget:self action:@selector(onLevelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:lvlBtn];
            [_butons addObject:lvlBtn];
            
            UIImageView *imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(xOffset + 44, 0, 1, 44)];
            imgViewLine.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            [self addSubview:imgViewLine];
            
            UIImageView *imgViewLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
            imgViewLine2.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            [self addSubview:imgViewLine2];
            
            xOffset += 44;
        }
        
        self.contentSize = CGSizeMake(xOffset, RectHeight(self.frame));
        [self setSelectedIndex:0];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)index {
    NSAssert(index < [_butons count], @"Index out of range");
    
    if (_selectedIndex != NSNotFound) {
        UIButton *selectedBtn = [_butons objectAtIndex:_selectedIndex];
        [selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    _selectedIndex = index;
    UIButton *newSelectedBtn = [_butons objectAtIndex:_selectedIndex];
    [newSelectedBtn setTitleColor:RGB(134, 197, 67) forState:UIControlStateNormal];
}

#pragma mark - Event Handlers
- (void)onLevelButtonTapped:(id)sender {
    NSInteger index = [_butons indexOfObject:sender];
    [self setSelectedIndex:index];
    
    [self.panelDelegate onSelectLevelWithIndex:index];
}

@end

//
//  UTExhibitDetailViewController.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTExhibitDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UTExhibit.h"
#import <OHAttributedLabel/OHAttributedLabel.h>

@interface UTExhibitDetailViewController () {
    UIScrollView *_scrollView;
}

@end

@implementation UTExhibitDetailViewController

#pragma mark - Life Cycle
- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = RGB(237, 234, 227);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 310, 310)];
    imageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    imageView.layer.borderWidth = 5.0;
    imageView.layer.borderColor = [[UIColor colorWithWhite:0.0 alpha:0.2] CGColor];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:self.exhibit.photoPath];
    [_scrollView addSubview:imageView];
    
    //315
    UIImageView *plane = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 45)];
    plane.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [_scrollView addSubview:plane];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(13, 10, 300 - 3, 45)];
    titleLbl.numberOfLines = 2;
    titleLbl.font = [UIFont systemFontOfSize:18];
    titleLbl.lineBreakMode = NSLineBreakByCharWrapping;
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.text = self.exhibit.name;
    [titleLbl sizeToFit];
    [_scrollView addSubview:titleLbl];
    
    OHAttributedLabel *detailText = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(10, 320, 300, 100)];
    detailText.backgroundColor = [UIColor clearColor];
    

    NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:self.exhibit.definition];

    [attrStr setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    [attrStr setTextColor:RGB(52, 48, 45)];
    
    OHParagraphStyle* paragraphStyle = [OHParagraphStyle defaultParagraphStyle];
    paragraphStyle.textAlignment = kCTJustifiedTextAlignment;
    paragraphStyle.lineBreakMode = kCTLineBreakByWordWrapping;
    paragraphStyle.firstLineHeadIndent = 30.f;
    paragraphStyle.lineSpacing = 3.f;
    [attrStr setParagraphStyle:paragraphStyle];
    
    [detailText setAttributedText:attrStr];
    
    CGSize size = [attrStr sizeConstrainedToSize:CGSizeMake(300, 10000)];
    detailText.frame = RectSetSize(detailText.frame, size.width, size.height);
    [_scrollView addSubview:detailText];
    
    _scrollView.contentSize = CGSizeMake(310, CGRectGetMaxY(detailText.frame));
}

- (void)viewWillAppear:(BOOL)animated  {
    _scrollView.frame = self.view.bounds;
}

#pragma mark - Methods

@end

//
//  MMRefreshLogoView.m
//  MMSuperViewController Demo
//
//  Created by Lanvige Jiang on 7/24/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMRefreshLogoView.h"

@implementation MMRefreshLogoView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.logoView];
    }
    
    return self;
}

- (UIView *)logoView
{
    // Add a logo view on head of tableview.
    if (!_logoView) {
        _logoView = [[UIView alloc] initWithFrame:CGRectMake(0.f, self.frame.size.height - 110.f, self.frame.size.width, 42)];
        _logoView.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MMSuperViewController.bundle/mms_list_header_logo.png"]];
        imageView.frame = CGRectMake(130, 0, 60, 42);
        [_logoView addSubview:imageView];
    }
    
    return _logoView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  EXErrorView.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMNetworkErrorDefaultView.h"

@implementation MMNetworkErrorDefaultView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.f];
		self.userInteractionEnabled = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.iconImageView.image = [UIImage imageNamed:@"MMSuperViewController.bundle/mms_error_icon.png"];
		self.titleLabel.text = @"Network not available.";
	}
    
	return self;
}

@end

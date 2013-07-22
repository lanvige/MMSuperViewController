//
//  EXListEmptyView.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMListEmptyDefaultView.h"

@implementation MMListEmptyDefaultView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.f];
		self.userInteractionEnabled = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.iconImageView.image = [UIImage imageNamed:@"MMSuperVewController.bundle/mms_empty_icon.png"];
		self.titleLabel.text = @"You don't have any lists.";
	}
    
	return self;
}


@end

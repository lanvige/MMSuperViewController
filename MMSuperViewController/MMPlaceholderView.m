//
//  EXEmptyView.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMPlaceholderView.h"

@implementation MMPlaceholderView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
		self.userInteractionEnabled = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor clearColor];
        
		[self addSubview:self.arrowImageView];
        [self addSubview:self.arrowLabel];
        [self addSubview:self.iconImageView];
		[self addSubview:self.titleLabel];
	}
    
	return self;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _arrowImageView;
}

- (UILabel *)arrowLabel
{
    if (!_arrowLabel) {
        _arrowLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_arrowLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
		_arrowLabel.textAlignment = NSTextAlignmentCenter;
		_arrowLabel.backgroundColor = [UIColor clearColor];
		_arrowLabel.font = [UIFont systemFontOfSize:19.0f];
		_arrowLabel.textColor = [UIColor colorWithWhite:0.294f alpha:0.45f];
    }
    
    return _arrowLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.numberOfLines = 2;
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.textColor = [UIColor colorWithRed:0.702f green:0.694f blue:0.686f alpha:1.0f];
		_titleLabel.font = [UIFont systemFontOfSize:16.0f];
		_titleLabel.shadowColor = [UIColor whiteColor];
		_titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    }
    
    return _titleLabel;
}


- (void)layoutSubviews
{
    CGSize size = self.frame.size;
    
	CGSize iconSize = _iconImageView.image.size;
	self.iconImageView.frame = CGRectMake(roundf((size.width - iconSize.width) / 2.0f), roundf((size.height - iconSize.height) / 2.0f) - 80, iconSize.width, iconSize.height);
	self.titleLabel.frame = CGRectMake(roundf((size.width - 280.0f) / 2.0f), _iconImageView.frame.origin.y + iconSize.height + 18.0f, 280.0f, 60.0f);
}

@end

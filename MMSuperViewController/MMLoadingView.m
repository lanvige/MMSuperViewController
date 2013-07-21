//
//  EXLoadingView.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMLoadingView.h"

static CGFloat interiorPadding = 20.0f;
static CGFloat indicatorSize = 20.0f;
static CGFloat indicatorRightMargin = 8.0f;

@interface MMLoadingView ()
- (void)_initialize;
@end

@implementation MMLoadingView

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame])) {
		[self _initialize];
	}
	return self;
}


- (void)drawRect:(CGRect)rect
{
	CGRect frame = self.frame;
	
	// Calculate sizes
	CGSize maxSize = CGSizeMake(frame.size.width - (interiorPadding * 2.0f) - indicatorSize - indicatorRightMargin,
								indicatorSize);
	
	CGSize textSize = [_textLabel.text sizeWithFont:_textLabel.font constrainedToSize:maxSize
									  lineBreakMode:NSLineBreakByWordWrapping];
	
	// Calculate position
	CGFloat totalWidth = textSize.width + indicatorSize + indicatorRightMargin;
	NSInteger y = (NSInteger)((frame.size.height / 2.0f) - (indicatorSize / 2.0f));
	
	// Position the indicator
	_activityIndicatorView.frame = CGRectMake((NSInteger)((frame.size.width - totalWidth) / 2.0f), y - 50, indicatorSize,
											  indicatorSize);
	
	// Calculate text position
	CGRect textRect = CGRectMake(_activityIndicatorView.frame.origin.x + indicatorSize + indicatorRightMargin, y - 50,
								 textSize.width, textSize.height);
	
	// Draw text
	[_textLabel drawTextInRect:textRect];
}


#pragma mark - Private

- (void)_initialize
{
	// View defaults
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.backgroundColor = [UIColor whiteColor];
	self.opaque = YES;
	self.contentMode = UIViewContentModeRedraw;
	
	// Setup label
	_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	
	// Setup the indicator
	_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	_activityIndicatorView.hidesWhenStopped = NO;
	[_activityIndicatorView startAnimating];
	[self addSubview:_activityIndicatorView];
	
	// Defaults
	_textLabel.text = @"Loading...";
	_textLabel.font = [UIFont systemFontOfSize:16.0f];
	_textLabel.textColor = [UIColor darkGrayColor];
	_textLabel.shadowColor = [UIColor whiteColor];
	_textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
}


@end

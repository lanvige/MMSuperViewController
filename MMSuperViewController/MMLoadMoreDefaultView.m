//
//  MMLoadMoreFooterView.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/26/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMLoadMoreDefaultView.h"

@interface MMLoadMoreDefaultView ()

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end


@implementation MMLoadMoreDefaultView

- (id)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 48)]) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [self addSubview:self.statusLabel];
        [self addSubview:self.activityView];
		[self setState:MMLoadMoreNormal];
    }
	
    return self;
}

#pragma mark -
#pragma mark UIView lazy init

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 12.f, self.frame.size.width, 20.0f)];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _statusLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        //        _statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        //        _statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _statusLabel;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityView.frame = CGRectMake(12, 12, 20.0f, 20.0f);
    }
    
    return _activityView;
}

#pragma mark -
#pragma mark Intranal methods

- (void)setState:(MMListLoadState)state
{
	switch (state) {
		case MMLoadMoreNormal: {
            [self addTarget:self
                     action:@selector(loadMoreAction:)
           forControlEvents:UIControlEventTouchUpInside];
			_statusLabel.text = NSLocalizedString(@"Load More", @"Load More items");
			[_activityView stopAnimating];
			break;
        }
		case MMLoadMoreLoading: {
            [self removeTarget:self
                        action:@selector(loadMoreAction:)
              forControlEvents:UIControlEventTouchUpInside];
			_statusLabel.text = NSLocalizedString(@"Loading...", @"Loading items");
			[_activityView startAnimating];
			break;
        }
		case MMLoadMoreFinished: {
            [self removeTarget:self
                        action:@selector(loadMoreAction:)
              forControlEvents:UIControlEventTouchUpInside];
			self.statusLabel.text = NSLocalizedString(@"No More", @"There is no more item");
			[self.activityView stopAnimating];
			break;
        }
		default:
			break;
	}
}

- (IBAction)loadMoreAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(loadMore)]) {
        [self.delegate loadMore];
    }
}

@end

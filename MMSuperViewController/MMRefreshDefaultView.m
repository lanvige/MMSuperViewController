//
//  RefreshHeaderView.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/26/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#define FLIP_ANIMATION_DURATION 0.18f
#define TMMT_COLOR [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]

#import "MMRefreshDefaultView.h"

@implementation MMRefreshDefaultView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor clearColor];
    
        [self addSubview:self.lastUpdatedLabel];
		[self addSubview:self.statusLabel];
		[self.layer addSublayer:self.arrowImage];
		[self addSubview:self.activityView];
        
        [self updateState:MMRefreshNormal withNewState:MMRefreshNormal];
    }
    
    return self;
}

#pragma mark -
#pragma mark UIView init


- (UILabel *)lastUpdatedLabel
{
    if (!_lastUpdatedLabel) {
        _lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		_lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_lastUpdatedLabel.font = [UIFont systemFontOfSize:12.0f];
		_lastUpdatedLabel.textColor = TMMT_COLOR;
		// _lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		// _lastUpdatedLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		_lastUpdatedLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lastUpdatedLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _statusLabel.textColor = TMMT_COLOR;
        // _statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        // _statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}

- (CALayer *)arrowImage
{
    if (!_arrowImage) {
        _arrowImage = [CALayer layer];
		_arrowImage.frame = CGRectMake(25.0f, self.frame.size.height - 65.0f, 30.0f, 55.0f);
		_arrowImage.contentsGravity = kCAGravityResizeAspect;
		_arrowImage.contents = (id)[UIImage imageNamed:@"MMSuperViewController.bundle/mms_refresh_arrow_gray.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			_arrowImage.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
    }
    
    return _arrowImage;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(25.0f, self.frame.size.height - 38.0f, 20.0f, 20.0f);
    }
    return _activityView;
}


#pragma mark -
#pragma mark 

- (void)updateLastUpdatedDate
{
	if (TRUE) {
		NSDate *date = [NSDate date];
        
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		
        formatter.dateStyle = kCFDateFormatterShortStyle;
        formatter.timeStyle = kCFDateFormatterShortStyle;
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        
        formatter.AMSymbol =  @"AM";
		formatter.PMSymbol = @"PM";
        
        // http://stackoverflow.com/questions/2246243/display-locale-language-in-full
		formatter.dateFormat = @"MM/dd/yyyy HH:mm:ss a";
		self.lastUpdatedLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Last Updated", nil), [formatter stringFromDate:date]];
        
        NSLog(@"%@", self.lastUpdatedLabel.text);
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text
                                                  forKey:@"RefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	} else {
		self.lastUpdatedLabel.text = nil;
	}
}



- (void)updateState:(MMListLoadState)currentState withNewState:(MMListLoadState)newState
{
	switch (newState) {
        case MMRefreshPulling: {
			self.statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			self.arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			break;
        }
		case MMRefreshNormal: {
			if (currentState == MMRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				self.arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			self.statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
			[self.activityView stopAnimating];
            
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			self.arrowImage.hidden = NO;
			self.arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self updateLastUpdatedDate];
			break;
        }
		case MMRefreshLoading: {
			self.statusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
			[self.activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			self.arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
        }
		default:
			break;
	}
}



@end

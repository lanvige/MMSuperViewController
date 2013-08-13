//
//  RefreshHeaderView.h
//  Explorer
//
//  Created by Lanvige Jiang on 6/26/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MMViewLoadState.h"

@protocol MMRefreshHeaderDelegate;

@interface MMRefreshDefaultView : UIView

@property (nonatomic, strong) UILabel *lastUpdatedLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) CALayer *arrowImage;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

- (void)updateLastUpdatedDate;
- (void)updateState:(MMViewLoadState)currentState withNewState:(MMViewLoadState)newState;

@end
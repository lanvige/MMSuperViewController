//
//  MMViewController.h
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMViewLoadState.h"

@interface MMSuperViewController : UIViewController

@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) UIView *loadingView;

- (NSPredicate *)predicate;

- (BOOL)empty;
- (void)updatePlaceholderViews:(BOOL)animated;
- (void)showLoadingView:(BOOL)animated;
- (void)hideLoadingView:(BOOL)animated;
- (void)showPlaceholderView:(BOOL)animated;
- (void)hidePlaceholderView:(BOOL)animated;

#pragma mark -
#pragma mark Data Operations

- (void)load;
- (void)loadCompleted;
- (void)loadCompletedWithAnimated:(BOOL)animated;

@end

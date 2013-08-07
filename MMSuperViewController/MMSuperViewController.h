//
//  MMViewController.h
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMSuperViewController : UIViewController

@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) UIView *loadingView;

- (NSPredicate *)predicate;

- (BOOL)empty;
- (void)updatePlaceholderViews:(BOOL)animated;
- (void)showLoadingView:(BOOL)animated;
- (void)hideLoadingView:(BOOL)animated;
- (void)showPlaceholderView:(BOOL)animated;
- (void)hidePlaceholderView:(BOOL)animated;

@end

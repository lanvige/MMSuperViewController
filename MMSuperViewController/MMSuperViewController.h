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

- (void)setLoading:(BOOL)loading animated:(BOOL)animated;
- (BOOL)empty;
- (void)updatePlaceholderViews:(BOOL)animated;
- (void)showLoadingView:(BOOL)animated;
- (void)hideLoadingView:(BOOL)animated;
- (void)showEmptyView:(BOOL)animated;
- (void)hideEmptyView:(BOOL)animated;

@end

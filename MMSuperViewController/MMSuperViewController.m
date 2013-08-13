//
//  MMViewController.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMSuperViewController.h"

@interface MMSuperViewController ()

@end


@implementation MMSuperViewController

#pragma mark - NSObject

- (void)dealloc
{
}


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    [self updatePlaceholderViews:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark -
#pragma mark Configuration

- (NSPredicate *)predicate
{
	return nil;
}

#pragma mark -
#pragma mark Setters

- (BOOL)empty
{
    return YES;
}

#pragma mark -
#pragma mark Load

- (void)load
{
    self.loading = YES;
    [self updatePlaceholderViews:NO];
    
    return;
}

- (void)loadCompleted
{
    [self loadCompletedWithAnimated:NO];
}

- (void)loadCompletedWithAnimated:(BOOL)animated
{
    self.loading = NO;
    
    [self updatePlaceholderViews:animated];
}

#pragma mark -

- (void)updatePlaceholderViews:(BOOL)animated
{
	animated = NO;
    
	// There is no content to be displayed.
	if (self.isLoading) {
		// Show the loading view and hide the no content view
		[self hidePlaceholderView:animated];
        
        if (self.empty) {
            [self showLoadingView:animated];
        }
	} else if (self.empty){
		// Show the no content view and hide the loading view
		[self hideLoadingView:animated];
		[self showPlaceholderView:animated];
	} else {
        [self hideLoadingView:animated];
		[self hidePlaceholderView:animated];
    }
}

- (void)showLoadingView:(BOOL)animated
{
	if (!self.loadingView) {
		return;
	}
    
	self.loadingView.alpha = 0.0f;
	self.loadingView.frame = self.view.bounds;
	[self.view addSubview:self.loadingView];
    
	void (^change)(void) = ^{
		self.loadingView.alpha = 1.0f;
        self.loadingView.userInteractionEnabled = NO;
	};
    
    
	if (animated) {
		[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:change completion:nil];
	} else {
		change();
	}
}

- (void)hideLoadingView:(BOOL)animated
{
	if (!self.loadingView || !self.loadingView.superview) {
		return;
	}
    
	void (^change)(void) = ^{
		self.loadingView.alpha = 0.0f;
        self.loadingView.userInteractionEnabled = YES;
	};
	
	void (^completion)(BOOL finished) = ^(BOOL finished) {
		[self.loadingView removeFromSuperview];
	};
	
	if (animated) {
		[UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:change
                         completion:completion];
	} else {
		change();
		completion(YES);
	}
}


- (void)showPlaceholderView:(BOOL)animated
{
	if (!self.placeholderView || self.placeholderView.superview) {
		return;
	}
	
	self.placeholderView.alpha = 0.0f;
	self.placeholderView.frame = self.view.bounds;
	[self.view addSubview:self.placeholderView];
	
	void (^change)(void) = ^{
		self.placeholderView.alpha = 1.0f;
	};
	
	if (animated) {
		[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:change completion:nil];
	} else {
		change();
	}
}


- (void)hidePlaceholderView:(BOOL)animated
{
	if (!self.placeholderView || !self.placeholderView.superview) {
		return;
	}
    
	void (^change)(void) = ^{
		self.placeholderView.alpha = 0.0f;
	};
	
	void (^completion)(BOOL finished) = ^(BOOL finished) {
		[self.placeholderView removeFromSuperview];
	};
	
	if (animated) {
		[UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:change
                         completion:completion];
	} else {
		change();
		completion(YES);
	}
}


#pragma mark - 
#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

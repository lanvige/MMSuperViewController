//
//  UIBarButtonItem+Explorer.m
//  Explorer
//
//  Created by Lanvige Jiang on 7/1/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "UIBarButtonItem+MMListViewController.h"

@implementation UIBarButtonItem (MMListViewController)

+ (UIBarButtonItem *)exAddButtonItemWithTarget:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 40.0, 27.0);
    [button setImage:[UIImage imageNamed:@"nav_notice_add"]
                forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_notice_add"]
                forState:UIControlStateHighlighted];
    [button addTarget:target
                   action:action
         forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


+ (UIBarButtonItem *)exRefreshButtonItemWithTarget:(id)target action:(SEL)aAction
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, 40.0, 27.0);
    [button setImage:[UIImage imageNamed:@"nav_refresh"]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_refresh"]
            forState:UIControlStateHighlighted];
    [button addTarget:target
               action:aAction
     forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)exActivityIndicatorButtonItem
{
    UIActivityIndicatorView *a = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    a.frame = CGRectMake(0.f, 0.f, 40.f, 27.f);
    [a startAnimating];
    
    return [[UIBarButtonItem alloc] initWithCustomView:a];
}

@end

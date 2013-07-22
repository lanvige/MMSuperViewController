//
//  UIBarButtonItem+Explorer.h
//  Explorer
//
//  Created by Lanvige Jiang on 7/1/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

// http://stackoverflow.com/questions/2455161/unrecognized-selector-sent-to-instance

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MMListViewController)

+ (UIBarButtonItem *)exRefreshButtonItemWithTarget:(id)target action:(SEL)aAction;
+ (UIBarButtonItem *)exActivityIndicatorButtonItem;

@end

//
//  MMLoadMoreFooterView.h
//  Explorer
//
//  Created by Lanvige Jiang on 6/26/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMListLoadState.h"
#import "UIBarButtonItem+MMListViewController.h"

@protocol LoadMoreTableFooterDelegate;


@interface MMLoadMoreDefaultView : UIControl

@property (nonatomic, weak) id<LoadMoreTableFooterDelegate> delegate;

- (void)setState:(MMListLoadState)state;

@end


@protocol LoadMoreTableFooterDelegate <NSObject>
@required
- (void)loadMore;
@end


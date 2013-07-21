//
//  MMTableViewController.h
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

typedef enum{
	MMListRefreshAndLoadMore = 0,
    MMListRefreshOnly,
    MMListLoadMoreOnly,
    MMListNone
} MMListTableType;

#import "MMViewController.h"
#import "MMRefreshDefaultView.h"
#import "MMListLoadState.h"
#import "MMLoadMoreDefaultView.h"

@interface MMListViewController : MMViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    LoadMoreTableFooterDelegate
    >

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong) MMRefreshDefaultView *refreshHeaderView;
@property (nonatomic, strong) MMLoadMoreDefaultView *loadMoreFooterView;
@property (nonatomic, assign, getter=isAllLoadFinished) BOOL allLoadFinished;
@property (nonatomic, assign, getter = isDragging) BOOL dragging;
@property (nonatomic, assign, getter = isLoadingMore) BOOL loadingMore;
@property (nonatomic, assign) MMListLoadState state;
@property (nonatomic, strong) UIView *logoView;


- (id)initWithListType:(MMListTableType)listType;

#pragma mark - PullToRefresh
- (void)refresh;
- (void)forceRefresh;
- (void)refreshCompleted;

#pragma mark - Load More
- (void)loadMore;
- (void)loadMoreCompleted;

- (void)hideLoadMoreView:(BOOL)animated;
- (void)showLoadMoreView:(BOOL)animated;
@end

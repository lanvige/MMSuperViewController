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

#import "MMSuperViewController.h"
#import "MMRefreshDefaultView.h"
#import "MMViewLoadState.h"
#import "MMLoadMoreDefaultView.h"

@interface MMSuperListViewController : MMSuperViewController <
    UITableViewDataSource,
    UITableViewDelegate,
    LoadMoreTableFooterDelegate
    >

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong) MMRefreshDefaultView *refreshHeaderView;
@property (nonatomic, strong) MMLoadMoreDefaultView *loadMoreFooterView;

@property (nonatomic, assign, getter=isRefreshing) BOOL refreshing;
@property (nonatomic, assign, getter=isAllLoadFinished) BOOL allLoadFinished;
@property (nonatomic, assign, getter=isDragging) BOOL dragging;
@property (nonatomic, assign, getter=isLoadingMore) BOOL loadingMore;
@property (nonatomic, assign) MMViewLoadState state;

- (id)initWithListType:(MMListTableType)listType;

#pragma mark -
#pragma mark Data Operations
#pragma mark PullToRefresh

- (void)refresh;
- (void)forceRefresh;
- (void)refreshCompleted;
- (void)refreshCompletedWithAnimated:(BOOL)animated;

#pragma mark -
#pragma mark Data Operations
#pragma mark Load More

- (void)loadMore;
- (void)loadMoreCompleted;
- (void)loadMoreCompletedWithAnimated:(BOOL)animated;

@end

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
#import "MMListLoadState.h"
#import "MMLoadMoreDefaultView.h"

@interface MMSuperListViewController : MMSuperViewController <
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


- (id)initWithListType:(MMListTableType)listType;

#pragma mark - PullToRefresh
- (void)refresh;
- (void)forceRefresh;
- (void)refreshCompletedWithAnimated:(BOOL)animated;

#pragma mark -
- (void)load;
- (void)loadCompletedWithAnimated:(BOOL)animated;

#pragma mark - Load More
- (void)loadMore;
- (void)loadMoreCompletedWithAnimated:(BOOL)animated;

@end

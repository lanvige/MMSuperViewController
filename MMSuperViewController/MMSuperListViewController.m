//
//  MMTableViewController.m
//  Explorer
//
//  Created by Lanvige Jiang on 6/28/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

#import "MMSuperListViewController.h"

@interface MMSuperListViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MMLoadMoreDefaultView *loadMoreNullView;
@property (nonatomic, assign) MMListTableType listType;
@end


@implementation MMSuperListViewController

#pragma mark -
#pragma mark NSObject

- (id)initWithListType:(MMListTableType)listType
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.listType = listType;
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -
#pragma mark UIView Lifecycle

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.tableView];
    
	//  update the last update date
    if (self.listType == MMListRefreshAndLoadMore || self.listType || MMListRefreshOnly) {
        [_refreshHeaderView updateLastUpdatedDate];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UIView lazy init


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView addSubview:self.logoView];
    }
    
    return _tableView;
}

- (UIView *)logoView
{
    // Add a logo view on head of tableview.
    if (!_logoView) {
        _logoView = [[UIView alloc] initWithFrame:CGRectMake(0, -110, 320, 42)];
        _logoView.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MMSuperVewController.bundle/mms_list_header_logo.png"]];
        imageView.frame = CGRectMake(130, 0, 60, 42);
        [_logoView addSubview:imageView];
    }
    
    return _logoView;
}

- (MMLoadMoreDefaultView *)loadMoreNullView
{
    if (!_loadMoreNullView) {
        _loadMoreNullView = [[MMLoadMoreDefaultView alloc] initWithFrame:CGRectZero];
    }
    
    return _loadMoreNullView;
}

- (void)setRefreshHeaderView:(MMRefreshDefaultView *)refreshHeaderView
{
    if (self.listType == MMListLoadMoreOnly || self.listType == MMListNone) {
        return;
    }
    
    _refreshHeaderView = refreshHeaderView;
    [_tableView addSubview:_refreshHeaderView];
}

- (void)setLoadMoreFooterView:(MMLoadMoreDefaultView *)loadMoreFooterView
{
    if (self.listType == MMListRefreshOnly || self.listType == MMListNone) {
        _loadMoreFooterView = self.loadMoreNullView;
    } else {
        _loadMoreFooterView = loadMoreFooterView;
        _loadMoreFooterView.delegate = self;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.listType == MMListNone) {
        return;
    }
    
    if (self.isRefreshing) {
        return;
    }
    
    self.dragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.listType == MMListLoadMoreOnly || self.listType == MMListNone) {
        return;
    }
    
	if (self.state == MMRefreshLoading) {
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
	} else if (self.isDragging) {
		if (self.state == MMRefreshPulling &&
            scrollView.contentOffset.y > -65.0f &&
            scrollView.contentOffset.y < 0.0f &&
            !self.isRefreshing) {
			[self setState:MMRefreshNormal];
		} else if (self.state == MMRefreshNormal &&
                   scrollView.contentOffset.y < -65.0f &&
                   !self.isRefreshing) {
			[self setState:MMRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.dragging = NO;
	if ((self.listType == MMListRefreshAndLoadMore || self.listType == MMListRefreshOnly) &&
        scrollView.contentOffset.y <= - 65.0f &&
        !self.isRefreshing) {
        [self refresh];
        
		[self setState:MMRefreshLoading];
        
        [UIView animateWithDuration:.2f
                         animations:^{
                             scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
                         }];
	}
    
	if (self.listType != MMListRefreshOnly && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height - 5) && !self.isLoadingMore && !self.isAllLoadFinished) {
        [self loadMore];
		[self setState:MMLoadMoreLoading];
	}
}

- (void)setState:(MMListLoadState)state
{
	switch (state) {
            // Refresh
        case MMRefreshPulling: {
			[self.refreshHeaderView updateState:self.state withNewState:MMRefreshPulling];
            break;
        }
		case MMRefreshNormal: {
			[self.refreshHeaderView updateState:self.state withNewState:MMRefreshNormal];
            break;
        }
		case MMRefreshLoading: {
			[self.refreshHeaderView updateState:self.state withNewState:MMRefreshLoading];
            break;
        }
            // Load More
		case MMLoadMoreNormal: {
            [self.loadMoreFooterView setState:MMLoadMoreNormal];
			break;
        }
		case MMLoadMoreLoading: {
            [self.loadMoreFooterView setState:MMLoadMoreLoading];
			break;
        }
		case MMLoadMoreFinished: {
            [self.loadMoreFooterView setState:MMLoadMoreFinished];
			break;
        }
		default:
			break;
	}
    
	_state = state;
}

#pragma mark -
#pragma mark Internal Methods (Refresh)

// about contentInset http://blog.csdn.net/catandrat111/article/details/8492564
- (void)forceRefresh
{
    [UIView animateWithDuration:.3f
                     animations:^{
                         // self.tableView.frame  = CGRectMake(60.0f, 0.0f, 0.0f, 0.0f);
                         self.tableView.contentOffset = CGPointMake(0.0f, -66.0f);
                         self.tableView.contentInset = UIEdgeInsetsMake(66.0f, 0.0f, 0.0f, 0.0f);
                     }];
    
    [self refresh];
}

- (void)refresh
{
    // TODO: add override warning]
    self.refreshing = YES;
    [self setState:MMRefreshLoading];
    
    return;
}

- (void)refreshCompleted
{
    self.refreshing = NO;
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         self.tableView.contentOffset = CGPointMake(0.0f, 0.0f);
                         self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
                     }];
	
	[self setState:MMRefreshNormal];
}

#pragma mark -
#pragma mark Internal Methods (Load More)
#pragma mark LoadMoreFootDelegate Methods

- (void)loadMore
{
    // TODO: add override warning
    [self setState:MMLoadMoreLoading];
    self.loadingMore = YES;
    
    return;
}

- (void)loadMoreCompleted
{
    self.loadingMore = NO;
    // 判断是否全部加载完成。
    if (self.isAllLoadFinished) {
        [self setState:MMLoadMoreFinished];
    } else {
        [self setState:MMLoadMoreNormal];
    }
}


#pragma mark -
#pragma mark Override superclass methods

- (void)setLoading:(BOOL)loading animated:(BOOL)animated
{
    [super setLoading:loading animated:animated];
    
//    if (self.refreshing) {
//        [self refresh];
//    } else {
//        [self refreshCompleted];
//    }
}

- (void)showLoadingView:(BOOL)animated
{
    if (!self.loadingView || self.loadingView.superview) {
        return;
    }
    
    self.loadingView.alpha = 0.0f;
    self.loadingView.frame = self.view.bounds;
    [self.tableView addSubview:self.loadingView];
    
    void (^change)(void) = ^{ self.loadingView.alpha = 1.0f; };
    
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:
            change completion:nil];
    } else {
        change();
    }
}

- (void)showEmptyView:(BOOL)animated
{
    // FIXME: 
//    if (!self.emptyView || !self.emptyView.superview) {
//        return;
//    }
    
    self.placeholderView.alpha = 0.0f;
    self.placeholderView.frame = self.view.bounds;
    [self.tableView addSubview:self.placeholderView];
    
    void (^change)(void) = ^{ self.placeholderView.alpha = 1.f; };
    
    if (animated) {
        [UIView animateWithDuration:.3f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:change completion:nil];
    } else {
        change();
    }
}


- (void)hideLoadMoreView:(BOOL)animated
{
    self.tableView.tableFooterView = self.loadMoreNullView;
}

- (void)showLoadMoreView:(BOOL)animated
{
    self.tableView.tableFooterView = self.loadMoreFooterView;
}

- (void)updatePlaceholderViews:(BOOL)animated
{
	animated = NO;
    
	// There is no content to be displayed.
	if ([self isRefreshing]) {
		// Show the loading view and hide the no content view
		[self hideEmptyView:animated];
        
        if ([self empty]) {
            [self showLoadingView:animated];
        }
	} else if ([self empty]){
		// Show the no content view and hide the loading view
		[self hideLoadingView:animated];
        [self hideLoadMoreView:animated];
		[self showEmptyView:animated];
	} else {
        [self hideLoadingView:animated];
		[self hideEmptyView:animated];
        if (self.listType == MMListRefreshAndLoadMore || self.listType == MMListLoadMoreOnly) {
            [self showLoadMoreView:animated];
        }
    }
}

#pragma mark -
#pragma mark Momery Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

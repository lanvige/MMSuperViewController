//
//  MMRefreshLoadState.h
//  Explorer
//
//  Created by Lanvige Jiang on 6/26/13.
//  Copyright (c) 2013 Lanvige Jiang. All rights reserved.
//

typedef enum{
    MMRefreshNormal = 0,
	MMRefreshPulling,
	MMRefreshLoading,
    MMRefreshCompleted,
    MMLoading,
    MMLoadCompleted,
    MMLoadMoreNormal,
    MMLoadMoreLoading,
    MMLoadMoreCompleted
} MMViewLoadState;
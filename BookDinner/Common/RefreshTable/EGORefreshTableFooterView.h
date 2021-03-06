//
//  EGORefreshTableFooterView.h
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//修改人：禚来强 iphone开发qq群：79190809 邮箱：zhuolaiqiang@gmail.com
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EGORefreshTableHeaderView.h"

@protocol EGORefreshTableFooterDelegate;

@interface EGORefreshTableFooterView : UIView {
    
	EGOPullRefreshState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
}

@property(nonatomic, weak) id<EGORefreshTableFooterDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView scrollFooterBack:(BOOL)animate withEdgeInsets:(UIEdgeInsets)edgeInsets;

@end

@protocol EGORefreshTableFooterDelegate <NSObject>

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view;
- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view;

@optional

- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view;

@end
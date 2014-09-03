//
//  HNYRefreshTableViewController.h
//  Demo
//
//  Created by zqchen on 13/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"

@protocol HNYRefreshTableViewControllerDelegate<NSObject>
@optional
//下拉Table View
-(void)pullDownTable;
//上拉Table View
-(void)pullUpTable;
//长按popover title
-(NSString*)descriptionOfTableCellAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface HNYRefreshTableViewController : UITableViewController <
EGORefreshTableFooterDelegate,
EGORefreshTableHeaderDelegate,
UIGestureRecognizerDelegate>
@property (nonatomic) BOOL enbleHeaderRefresh;
@property (nonatomic) BOOL enbleFooterLoad;
@property (nonatomic) BOOL headerIsUpdateing;
@property (nonatomic) BOOL footerIsLoading;
@property (nonatomic) int pageNum;
@property (nonatomic) int pageSize;
@property (nonatomic) int loadType;
@property (nonatomic,  weak) id <HNYRefreshTableViewControllerDelegate> delegate;
@property (nonatomic,strong) EGORefreshTableHeaderView *updateHeaderView;
@property (nonatomic,strong) EGORefreshTableFooterView *updateFooterView;
@property (nonatomic,strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic,strong) NSMutableArray *list;

- (void)addObjectsFromAry:(NSArray*)array;
- (void)doneRefresh;
@end

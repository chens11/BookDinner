//
//  HNYTabBar.h
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNYTabBarItem.h"

@interface HNYTabBar : UIView

@property (nonatomic,strong) NSArray *tabItemsAry;
@property (nonatomic) int selectIndex;
@property (nonatomic) int defaultSelectedIndex;

- (void)selectTabItemByIndex:(int)Index;
@end

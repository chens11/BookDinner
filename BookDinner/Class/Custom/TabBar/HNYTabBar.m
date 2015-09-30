//
//  HNYTabBar.m
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTabBar.h"
#import "HNYScrollView.h"

@interface HNYTabBar()<HNYTabBarItemDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) HNYScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation HNYTabBar
@synthesize tabItemsAry = _tabItemsAry;
@synthesize defaultSelectedIndex = _defaultSelectedIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.imageView setImage:[UIImage imageNamed:@"menu-bg"]];
        [self addSubview:self.imageView];
        
        self.scrollView = [[HNYScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.delegate = self;
        self.scrollView.canCancelContentTouches = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    float offset  = 0;
    
    if (self.tabItemsAry.count < 6)
        offset  = (frame.size.width - frame.size.width/5 * self.tabItemsAry.count)/2;
    else
        self.scrollView.contentSize = CGSizeMake(frame.size.width/5 * self.tabItemsAry.count, frame.size.height);
    
    for (HNYTabBarItem *item in self.tabItemsAry) {
        
        int index = [self.tabItemsAry indexOfObject:item];
        item.frame = CGRectMake(offset + frame.size.width*index/5, 0, frame.size.width/5, frame.size.height);
        [item setNeedsDisplay];
    }
}

- (void)setTabItemsAry:(NSArray *)tabItemsAry{
    for (HNYTabBarItem *item in _tabItemsAry) {
        [item removeFromSuperview];
    }
    _tabItemsAry = tabItemsAry;
    
    for (HNYTabBarItem *item in self.tabItemsAry) {
        item.delegate = self;
        [self.scrollView addSubview:item];
    }
    [self layoutSubviews];
}

#pragma mark - HBTabBarItemDelegate
- (void)selectedTabBarItem:(HNYTabBarItem *)sender{
    if (self.selectIndex < self.tabItemsAry.count) {
        HNYTabBarItem *item = [self.tabItemsAry objectAtIndex:self.selectIndex];
        item.selected = NO;
    }
    self.selectIndex = [self.tabItemsAry indexOfObject:sender];
    //    self.scrollView.contentOffset = CGPointMake(sender.frame.size.width * self.selectIndex, 0);
}

- (void)setDefaultSelectedIndex:(int)defaultSelectedIndex{
    _defaultSelectedIndex = defaultSelectedIndex;
    if (self.tabItemsAry.count > 0 && defaultSelectedIndex < self.tabItemsAry.count) {
        HNYTabBarItem *barItem = [self.tabItemsAry objectAtIndex:defaultSelectedIndex];
        [barItem touchButton:barItem.button];
    }
}

- (void)selectTabItemByIndex:(int)Index{
    if (self.tabItemsAry.count > 0 && Index < self.tabItemsAry.count) {
        CGPoint point = self.scrollView.contentOffset;
        HNYTabBarItem *barItem = [self.tabItemsAry objectAtIndex:Index];
        
        if (barItem.frame.origin.x < point.x) {
            [self.scrollView setContentOffset:CGPointMake(barItem.frame.origin.x, 0)];
        }
        else if (barItem.frame.origin.x > (point.x + self.scrollView.frame.size.width - 10)){
            if ((barItem.frame.origin.x + self.scrollView.frame.size.width) > self.scrollView.contentSize.width) {
                [self.scrollView setContentOffset:CGPointMake(barItem.frame.origin.x -  self.scrollView.frame.size.width + barItem.frame.size.width, 0)];
            }
        }
        
        [barItem touchButton:barItem.button];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.pagingEnabled = YES;
}


@end

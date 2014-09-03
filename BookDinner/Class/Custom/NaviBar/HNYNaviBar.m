//
//  HNYNaviBar.m
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYNaviBar.h"

@interface HNYNaviBar ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *bottomLine;
@property (nonatomic) float offset;

@end

@implementation HNYNaviBar
@synthesize leftItems = _leftItems;
@synthesize rightItems = _rightItems;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.offset = 20;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7) {
            self.offset = 0;
        }
        self.backgroundColor = [UIColor whiteColor];
        
        self.bottomLine = [[UILabel alloc] init];
        self.bottomLine.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
        self.bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.bottomLine];

        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
//        [self.imageView setImage:[UIImage imageNamed:@"naviBar"]];
        self.imageView.backgroundColor = [UIColor blackColor];
//        [self addSubview:self.imageView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.offset, frame.size.width, frame.size.height - self.offset)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont boldSystemFontOfSize:20.0];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
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
    self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.bottomLine.frame = CGRectMake(0, frame.size.height - 1, frame.size.width, 1);
    float labelX = 0;
    for (HNYNaviBarItem *item in self.leftItems) {
        int index = [self.leftItems indexOfObject:item];
        item.center = CGPointMake(item.frame.size.width/2 + item.frame.size.width * index, (self.frame.size.height + self.offset)/2);
        labelX += item.frame.size.width;
    }
    
    for (HNYNaviBarItem *item in self.rightItems) {
        int index = [self.rightItems indexOfObject:item];
        item.center = CGPointMake(self.frame.size.width -(item.frame.size.width/2 + item.frame.size.width * index), (self.frame.size.height + self.offset)/2);
    }
    
    self.label.frame = CGRectMake(0, self.offset, frame.size.width, frame.size.height - self.offset);
    [self resizeTitleLabel];
    
}
- (void)setLeftItems:(NSArray *)leftItems{
    _leftItems = leftItems;
    for (HNYNaviBarItem *item in leftItems) {
        int index = [leftItems indexOfObject:item];
        item.center = CGPointMake(item.frame.size.width/2 + item.frame.size.width * index, (self.frame.size.height + self.offset)/2);
        [self addSubview:item];
    }
}

- (void)setRightItems:(NSArray *)rightItems{
    _rightItems = rightItems;
    for (HNYNaviBarItem *item in rightItems) {
        int index = [rightItems indexOfObject:item];
        item.center = CGPointMake(self.frame.size.width -(item.frame.size.width/2 + item.frame.size.width * index), (self.frame.size.height + self.offset)/2);
        [self addSubview:item];
    }
}


#pragma mark - HBTabBarItemDelegate
//- (void)selectedTabBarItem:(HBTabBarItem *)sender{
//    HBTabBarItem *item = [self.tabItemsAry objectAtIndex:self.selectIndex];
//    item.selected = NO;
//    self.selectIndex = [self.tabItemsAry indexOfObject:sender];
//}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
}

- (void)resizeTitleLabel{
    if (self.label.text.length > 0) {
        CGSize size = [self.label.text sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:CGSizeMake(600, 22) lineBreakMode:NSLineBreakByWordWrapping];
        if (size.width > (self.frame.size.width - self.offset - HNYNaviBarItemWidth * self.leftItems.count)) {
            CGRect frame = self.label.frame;
            frame.origin.x = self.offset + HNYNaviBarItemWidth * self.leftItems.count;
            frame.size.width = self.frame.size.width - self.offset - HNYNaviBarItemWidth * self.leftItems.count;
            self.label.frame = frame;
        }
    }
}

#pragma mark - UIScrollViewDelegate

@end

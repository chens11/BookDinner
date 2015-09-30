//
//  BDToolBar.m
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDToolBar.h"
#import "HNYScrollView.h"

#define SubMenuWidth 64
@interface BDToolBar()<HNYDelegate>
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) HNYScrollView *scrollView;
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UILabel *bottomLine;

@end

@implementation BDToolBar
@synthesize subMenuAry = _subMenuAry;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.topImageView = [[UIImageView alloc] init];
        [self.topImageView setImage:[UIImage imageNamed:@"iconSubMenuBg"]];
        //        [self addSubview:self.topImageView];
        
        self.scrollView = [[HNYScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.scrollView];
        
        self.bottomLine = [[UILabel alloc] init];
        self.bottomLine.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
        self.bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.bottomLine];
        
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.topImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.bottomLine.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    for (BDToolBarItem *item in self.items) {
        NSInteger index = [self.items indexOfObject:item];
        item.frame = CGRectMake(SubMenuWidth * index , 0, SubMenuWidth, self.frame.size.height);
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)setSubMenuAry:(NSMutableArray *)subMenuAry{
    _subMenuAry = subMenuAry;
    self.items = [NSMutableArray array];
    if (subMenuAry.count > 0) {
        self.scrollView.contentSize = CGSizeMake(SubMenuWidth * subMenuAry.count, self.frame.size.height);
    }
    for (BDMenuModel *model in subMenuAry) {
        NSInteger index = [subMenuAry indexOfObject:model];
        BDToolBarItem *item = [[BDToolBarItem alloc] init];
        item.delegate = self;
        item.menuModel = model;
        item.exTag = index;
        [self.scrollView addSubview:item];
        [self.items addObject:item];
    }
    [self layoutSubviews];
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex{
    _defaultSelectedIndex = defaultSelectedIndex;
    if (self.subMenuAry.count > 0 && defaultSelectedIndex < self.subMenuAry.count) {
        self.selectIndex = defaultSelectedIndex;
        BDToolBarItem *item = [self.items objectAtIndex:defaultSelectedIndex];
        item.selected = YES;
        [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:[self.subMenuAry objectAtIndex:defaultSelectedIndex],@"subMenuSelected", nil]];
    }
}

#pragma mark - HBPublicDelegate
- (void)view:(BDToolBarItem *)aView actionWitnInfo:(NSDictionary *)info{
    BDToolBarItem *item = [self.items objectAtIndex:self.selectIndex];
    if (self.selectIndex != aView.exTag) {
        item.selected = NO;
        self.selectIndex = aView.exTag;
    }
    [self.delegate view:self actionWitnInfo:info];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.pagingEnabled = YES;
}

@end
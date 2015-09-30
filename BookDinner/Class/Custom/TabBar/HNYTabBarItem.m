//
//  HNYTabBarItem.m
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTabBarItem.h"

@interface HNYTabBarItem()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSURL *normalUrl;
@property (nonatomic,strong) NSURL *downUrl;
@property (nonatomic,strong) UIImage *normalImg;
@property (nonatomic,strong) UIImage *downImg;
@property (nonatomic,weak) id target;
@property (nonatomic) SEL action;

@end

@implementation HNYTabBarItem
@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.bgImageView];
        
        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.label];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    self.bgImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height * 2/3);
    self.label.frame = CGRectMake(0, frame.size.height * 2/3, frame.size.width, frame.size.height/3);
    self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

#pragma mark - class method

+ (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    HNYTabBarItem *item = [[HNYTabBarItem alloc] initWithFrame:CGRectZero];
    [item initWithImage:image target:target action:action];
    return item;
}

+ (id)initWithNormalImageUrl:(NSString *)normalImgUrl downImageUrl:(NSString*)downImgUrl title:(NSString*)title target:(id)target action:(SEL)action{
    HNYTabBarItem *item = [[HNYTabBarItem alloc] initWithFrame:CGRectZero];
    [item initWithNormalImageUrl:normalImgUrl downImageUrl:downImgUrl title:title target:target action:action];
    return item;
}

+ (id)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg title:(NSString *)title target:(id)target action:(SEL)action{
    HNYTabBarItem *item = [[HNYTabBarItem alloc] initWithFrame:CGRectZero];
    [item initWithNormalImage:normalImg downImage:downImg title:title target:target action:action];
    return item;
    
}

- (void)initWithNormalImageUrl:(NSString *)normalImgUrl downImageUrl:(NSString*)downImgUrl title:(NSString*)title target:(id)target action:(SEL)action{
    
    self.normalUrl = [NSURL URLWithString:normalImgUrl];
    self.downUrl = [NSURL URLWithString:downImgUrl];
    [self.bgImageView setImageWithURL:[NSURL URLWithString:normalImgUrl]];
    self.label.text = title;
    self.target = target;
    self.action = action;
    
}

- (void)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg title:(NSString *)title target:(id)target action:(SEL)action{
    self.normalImg = normalImg;
    self.downImg = downImg;
    self.bgImageView.image = self.normalImg;
    self.label.text = title;
    self.target = target;
    self.action = action;
    
}

- (void)initWithImage:(UIImage *)image target:(id)target action:(SEL)action{
    [self.bgImageView setImage:image];
    self.target = target;
    self.action = action;
}

#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    if (self.selected == NO) {
        [self.delegate selectedTabBarItem:self];
        [self.target performSelector:self.action withObject:self];
        self.selected = YES;
    }
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (self.normalUrl && self.normalUrl) {
        if (selected)
            [self.bgImageView setImageWithURL:self.downUrl];
        else
            [self.bgImageView setImageWithURL:self.normalUrl];
    }else{
        if (selected)
            self.bgImageView.image = self.downImg;
        else
            self.bgImageView.image = self.normalImg;
    }
    
}
@end

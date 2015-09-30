//
//  HNYNaviBarItem.m
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYNaviBarItem.h"
@interface HNYNaviBarItem()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSURL *normalUrl;
@property (nonatomic,strong) NSURL *downUrl;
@property (nonatomic,strong) UIImage *normalImg;
@property (nonatomic,strong) UIImage *downImg;
@property (nonatomic,weak) id target;
@property (nonatomic) SEL action;

@end

@implementation HNYNaviBarItem
@synthesize selected = _selected;

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    self.label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.button.center = CGPointMake(frame.size.width/2, frame.size.height/2);
}

#pragma mark - class method


+ (HNYNaviBarItem *)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg target:(id)target action:(SEL)action{
    HNYNaviBarItem *item = [[HNYNaviBarItem alloc] initWithNormalImage:normalImg downImage:downImg target:target action:action];
    return item;
}


+ (HNYNaviBarItem *)initWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    HNYNaviBarItem *item = [[HNYNaviBarItem alloc] initWithTitle:title target:target action:action];
    return item;
}

#pragma mark - init fun
- (HNYNaviBarItem *)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg target:(id)target action:(SEL)action{
    
    self = [super initWithFrame:CGRectMake(0, 0, normalImg.size.width + 16, 44)];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.label];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.showsTouchWhenHighlighted = YES;
        [self.button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        self.normalImg = normalImg;
        self.downImg = downImg;
        self.label.hidden = YES;
        self.target = target;
        self.action = action;
        [self.button setImage:normalImg forState:UIControlStateNormal];

    }
    
    return self;
}


- (HNYNaviBarItem *)initWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(150, 44) lineBreakMode:NSLineBreakByWordWrapping];
    self = [super initWithFrame:CGRectMake(0, 0, size.width + 16, 44)];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.label];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.showsTouchWhenHighlighted = YES;
        [self.button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        self.button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.button setTitle:title forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.target = target;
        self.action = action;
        
    }
    
    return self;

    
}
#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    [self.target performSelector:self.action withObject:self];
}

@end

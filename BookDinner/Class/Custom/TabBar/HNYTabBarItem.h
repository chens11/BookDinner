//
//  HNYTabBarItem.h
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"


@class HNYTabBarItem;
@protocol  HNYTabBarItemDelegate <NSObject>

- (void)selectedTabBarItem:(HNYTabBarItem*)sender;

@end

@interface HNYTabBarItem : UIView
@property (nonatomic) int  exTag;
@property (nonatomic,weak) id <HNYTabBarItemDelegate> delegate;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic) BOOL selected;


+ (id)initWithNormalImageUrl:(NSString *)normalImgUrl downImageUrl:(NSString*)downImgUrl title:(NSString*)title target:(id)target action:(SEL)action;

+ (id)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg title:(NSString*)title target:(id)target action:(SEL)action;

+ (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;


- (void)initWithNormalImageUrl:(NSString *)normalImgUrl downImageUrl:(NSString*)downImgUrl title:(NSString*)title target:(id)target action:(SEL)action;

- (void)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg title:(NSString*)title target:(id)target action:(SEL)action;

- (void)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)touchButton:(UIButton*)sender;

@end

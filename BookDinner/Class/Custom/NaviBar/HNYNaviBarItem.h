//
//  HNYNaviBarItem.h
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNYNaviBarItem : UIView
@property (nonatomic,strong) UIButton *button;
@property (nonatomic) BOOL selected;
@property (nonatomic) int  exTag;

+ (HNYNaviBarItem *)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg  target:(id)target action:(SEL)action;
+ (HNYNaviBarItem *)initWithTitle:(NSString *)title  target:(id)target action:(SEL)action;

- (HNYNaviBarItem *)initWithNormalImage:(UIImage *)normalImg downImage:(UIImage *)downImg  target:(id)target action:(SEL)action;
- (HNYNaviBarItem *)initWithTitle:(NSString *)title  target:(id)target action:(SEL)action;


@end

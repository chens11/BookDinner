//
//  PXAlertView.h
//  PXAlertViewDemo
//
//  Created by Alex Jarvis on 25/09/2013.
//  Copyright (c) 2013 Panaxiom Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNYDelegate.h"

static const CGFloat AlertViewWidth = 270.0;
static const CGFloat AlertViewContentMargin = 9;
static const CGFloat AlertViewVerticalElementSpace = 10;
static const CGFloat AlertViewButtonHeight = 44;

@interface PXAlertView : UIView
@property (nonatomic, getter = isVisible) BOOL visible;
- (void)hide;

+ (PXAlertView *)showAlertWithTitle:(NSString *)title;

+ (PXAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message;

+ (PXAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                         completion:(void(^) (BOOL cancelled))completion;

+ (PXAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                         completion:(void(^) (BOOL cancelled))completion;

+ (PXAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                         otherTitle:(NSString *)otherTitle
                         completion:(void(^) (BOOL cancelled))completion;

+ (PXAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                         otherTitle:(NSString *)otherTitle
                        contentView:(UIView *)view
                         completion:(void(^) (BOOL cancelled))completion;

+ (PXAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                        cancelTitle:(NSString *)cancelTitle
                         otherTitle:(NSString *)otherTitle
                        contentView:(UIView *)view
                           delegate:(id<HNYDelegate>)delegate;


@end

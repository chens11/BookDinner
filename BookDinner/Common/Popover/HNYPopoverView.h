//
//  HNYPopoverView.h
//  Demo
//
//  Created by chenzq on 4/18/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#define HNYArrowHeight 14.0;
#define HNYArrowOffset 2.0f;
#define HNYPopoverViewCornerRadius 4.0f;
#define HNYPopoverViewTextFont 14.0f;
#define HNYPopoverViewTitleFont 15.0f;
#define HNYPopoverViewStringAryCellHeight 44

#import <UIKit/UIKit.h>
@class HNYPopoverView;

@protocol HNYPopoverViewDelegate <NSObject>
@optional

/* Called on the delegate when the popover controller will dismiss the popover. Return NO to prevent the dismissal of the view.
 */
- (void)hNYPopoverViewWillDismissPopover:(HNYPopoverView *)popover;

/* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
 */
- (void)hNYPopoverViewDidDismissPopover:(HNYPopoverView *)popover;

// caled when select the String ary
- (void)hNYPopoverView:(HNYPopoverView *)popover didSelectStringAryAtIndex:(NSInteger)index;

@end



@interface HNYPopoverView : UIView
@property (nonatomic, assign) id <HNYPopoverViewDelegate> delegate;

#pragma mark - Class Static presenting Methods
//These are the main static methods you can use to display the popover.
//Simply call [PopoverView present...] with your arguments, and the popover will be generated, added to the view stack, and notify you when it's done.
+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate;

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate;

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate;

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate;

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withStringAry:(NSArray*)strAry delegate:(id<HNYPopoverViewDelegate>)delegate;

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withStringAry:(NSArray*)strAry delegate:(id<HNYPopoverViewDelegate>)delegate;

#pragma mark - Instance presenting Methods
//Adds/animates in the popover to the top of the view stack with the arrow pointing at the "point"
//within the specified view.  The contentView will be added to the popover, and should have either
//a clear color backgroundColor, or perhaps a rounded corner bg rect (radius 4.f if you're going to
//round).

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withText:(NSString *)text;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withContentView:(UIView *)cView;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withStringAry:(NSArray*)strAry ;

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withStringAry:(NSArray*)strAry;

//- (void)presentPopoverAnimated:(BOOL)animated;

- (void)dismissPopoverAnimated:(BOOL)animated;

@end

//
//  HNYActionSheet.h
//  VillageEducation
//
//  Created by chenzq on 4/24/14.
//  Copyright (c) 2014 hubei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HNYActionSheetButtonHeight 44
#define HNYActionSheetStringAryCellHeight 44
@class HNYActionSheet;

@protocol HNYActionSheetDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)hNYActionSheetCancel:(HNYActionSheet *)actionSheet;

// caled when select the String ary
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet didSelectStringAryAtIndex:(NSInteger)index;

- (void)willPresentHNYActionSheet:(HNYActionSheet *)actionSheet;  // before animation and showing view

- (void)didPresentHNYActionSheet:(HNYActionSheet *)actionSheet;  // after animation

// before animation and hiding view
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;

// after animation
- (void)hNYActionSheet:(HNYActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

@interface HNYActionSheet : UIView
@property (nonatomic,weak) id <HNYActionSheetDelegate> delegate;
#pragma mark - Class Static show action sheet Methods

//static class fun to create HNYActionSheet with title contentView cancelButton sureButton and delegate
+ (HNYActionSheet*)showWithTitle:(NSString*)title contentView:(UIView*)cView cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle delegate:(id<HNYActionSheetDelegate>)delegate;

//static class fun to create HNYActionSheet with title string array cancelButton sureButton and delegate
+ (HNYActionSheet*)showWithTitle:(NSString*)title withStringAry:(NSArray*)strAry cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle delegate:(id<HNYActionSheetDelegate>)delegate;

#pragma mark - Instance show action Methods

//static class fun to create HNYActionSheet with title string array cancelButton sureButton and delegate
- (void)showWithTitle:(NSString*)title withStringAry:(NSArray*)strAry cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle;

//instance fun to create HNYActionSheet
- (void)showWithTitle:(NSString*)title contentView:(UIView *)cView cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle;

- (void)show;//instacne fun to show HNYActionSheet

- (void)hide; //instacne fun to hide HNYActionSheet

@end

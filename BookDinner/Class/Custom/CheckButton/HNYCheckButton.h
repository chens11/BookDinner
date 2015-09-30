//
//  HNYCheckButton.h
//  exoa_mobile
//
//  Created by chen zq on 10/11/13.
//
//

#import <UIKit/UIKit.h>

@class HNYCheckButton;

@protocol HNYCheckButtonDelegate <NSObject>
@required
- (void)checkButton:(HNYCheckButton*)checkButton selectedBySender:(UIButton*)sender;

@end


@interface HNYCheckButton : UIView
@property (nonatomic) int exTag;

@property (nonatomic,strong) NSString *nameKey;
//列表对应的id的id名
@property (nonatomic,strong) NSString *valueKey;

@property (nonatomic) BOOL selected;

@property (nonatomic,weak) id<HNYCheckButtonDelegate> delegate;

- (void)setUpWithObject:(id)object;

@end

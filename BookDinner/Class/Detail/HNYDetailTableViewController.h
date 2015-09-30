//
//  HNYDetailTableViewController.h
//  exoa_mobile
//
//  Created by chenzq on 5/14/13.
//
//

#import <UIKit/UIKit.h>
#import "HNYDetailItemModel.h"
#import "HNYDelegate.h"

@class HNYDetailTableViewController;

@protocol HNYDetailTableViewControllerDelegate <NSObject>
@optional
//item值改变的时候，改delegate传出值
- (void)valueDicChange:(HNYDetailTableViewController *)controller withValue:(id)value andKey:(NSString *)key;
- (void)tableViewController:(HNYDetailTableViewController *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
///自定义view创建
- (id)createViewWith:(HNYDetailItemModel*)item;
@end


@interface HNYDetailTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,HNYDetailTableViewControllerDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIColor *backGroundColor;
@property (nonatomic,strong) UIColor *cellBackGroundColor;
@property (nonatomic,strong) UIColor *separatorLineColor;

@property (nonatomic,strong) UIColor *nameTextColor;
@property(nonatomic)NSTextAlignment nameTextAlignment;
@property (nonatomic,strong) UIFont *nameTextFont;

@property (nonatomic,strong) UIColor *valueTextColor;
@property (nonatomic,strong) UIFont *valueTextFont;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,strong) NSArray *viewAry;
@property (nonatomic,strong) NSMutableDictionary *valueDic;

@property (nonatomic,weak) id<HNYDelegate> delegate;
@property (nonatomic,weak) id<HNYDetailTableViewControllerDelegate> customDelegate;

@property (nonatomic) float nameLabelWidth;

//外部修改viewAry里面的内容某个item的值
- (void)changeViewAryObjectWith:(HNYDetailItemModel*)item atIndex:(NSInteger)index;

- (HNYDetailItemModel*)getItemWithKey:(NSString*)key;

@end

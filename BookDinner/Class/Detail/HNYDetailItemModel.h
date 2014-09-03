//
//  HNYDetailItemModel.h
//  exoa_mobile
//
//  Created by chenzq on 6/3/13.
//
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "HNYTextField.h"

typedef enum HNYViewType{
    TextView = 0,
    CustomTextView = 1,//ipad 地址本
    InnerMailAttachmentPreviewVC = 2,//显示附件
    OpinionRelayTableViewController = 3,//显示回复列表
    WebView = 4,
    IPCustomTextView = 5,//iphone
    DropDownListPopoverDate = 6,//ipad
    DropDownListPopoverComBox = 7,//ipad
    Customer = 8,
    Label = 9,
    Switch = 10,
    MultiFunctionTextViewDate = 11,//iphone
    MultiFunctionTextViewComBox = 12,//iphone
    CustomerDropDownTable = 13,//自定义下拉列表
    CustomerChoiceView = 14,//自定义选择空间
    ImageView = 15,//
    TextField = 16,//
    TextFieldPopoverList = 17,//
}HNYViewType;

@interface HNYDetailItemModel : NSObject
//控件类型
@property (nonatomic,assign) HNYViewType viewType;
//是否可编辑
@property (nonatomic) BOOL editable;
//该项前面显示的名字
@property (nonatomic,strong) NSString  *name;
//控件的显示值,并且会用于判断控件的高度
@property (nonatomic,strong) NSString  *textValue;
//控件的值
@property (nonatomic,strong) id  value;
//改控件的标识
@property (nonatomic,strong) NSString *key;
//控件的高度
@property (nonatomic,strong) NSString *height;
//控件的最大高度
@property (nonatomic) float maxheight;
//控件的最小高度
@property (nonatomic) float minheight;
//控件的数据源
@property (nonatomic,strong) id dataSource;
//控件的数据源
@property (nonatomic,strong) id params;
//控件显示边框
@property (nonatomic) BOOL showBorder;
//控件边框颜色
@property (nonatomic,strong) UIColor *borderColor;
//显示字体颜色
@property (nonatomic,strong) UIColor *textColor;
//显示字体大小
@property (nonatomic,strong) UIFont *textFont;
//控件背景颜色
@property (nonatomic,strong) UIColor *backGroundColor;
//控件透明效果
@property (nonatomic) float alpha;
// default is NSLeftTextAlignment
@property(nonatomic)NSTextAlignment textAlignment;
//控件背景图片
@property (nonatomic,strong) UIImage *backGroundImage;
//控件所用的键盘回车键类型
@property(nonatomic) UIReturnKeyType returnKeyType;
//控件所用的键盘类型
@property(nonatomic) UIKeyboardType keyboardType;
//控件显示背景字
@property(nonatomic,strong) NSString *placeholder;
//控件服务名
@property(nonatomic,strong) NSString *serviceName;
//时间控件时间格式
@property(nonatomic,strong) NSString *dateDataFormat;
//时间控件显示时间格式
@property (nonatomic,strong) NSString *dateShowFormat;
//容器
@property (nonatomic,weak) UIViewController *container;
@property (nonatomic,strong) NSString *voName;
@property (nonatomic,strong) id style;
@property (nonatomic) float nameLabelWidth;
@property (nonatomic) BOOL returnOrignal;
@property (nonatomic) BOOL required;
@property (nonatomic,strong) NSString *title;
//特殊控件的size
@property (nonatomic) CGSize viewSize;
//右边间隔
@property (nonatomic) float rightPadding;
// default is UITableViewCellAccessoryNone. use to set standard type
@property (nonatomic) UITableViewCellAccessoryType    accessoryType;
@property(nonatomic) BOOL secureTextEntry;       // default is NO
@property(nonatomic) UIViewContentMode contentMode;                // default is UIViewContentModeScaleToFill

+ (id)createViewWith:(HNYDetailItemModel *)itemVO andTarget:(id)target;

@end

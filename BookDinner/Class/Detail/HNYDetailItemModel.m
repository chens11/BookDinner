//
//  EXDetailTableItemVO.m
//  exoa_mobile
//
//  Created by chenzq on 6/3/13.
//
//

#import "HNYDetailItemModel.h"


@implementation HNYDetailItemModel
@synthesize viewType = _viewType;
@synthesize editable = _editable;
@synthesize name;
@synthesize value;
@synthesize key;
@synthesize params;
@synthesize height = _height;
@synthesize dataSource;
@synthesize serviceName;
@synthesize textValue;
@synthesize maxheight;
@synthesize showBorder = _showBorder;
@synthesize textColor = _textColor;
@synthesize borderColor = _borderColor;
@synthesize backGroundColor = _backGroundColor;
@synthesize alpha = _alpha;
@synthesize backGroundImage = _backGroundImage;
@synthesize returnKeyType = _returnKeyType;
@synthesize keyboardType = _keyboardType;
@synthesize placeholder = _placeholder;
@synthesize textFont = _textFont;
@synthesize container;
@synthesize dateDataFormat;
@synthesize dateShowFormat;
@synthesize voName;
@synthesize nameLabelWidth;
@synthesize returnOrignal;
@synthesize style;
@synthesize required;
@synthesize title = _title;
@synthesize minheight;
@synthesize viewSize;

- (void)setViewType:(HNYViewType)viewType{
    _viewType = viewType;
}

- (void)setEditable:(BOOL)editable{
    _editable = editable;
}

- (BOOL)editable{
    if (_editable == NO) {
        return NO;
    }
    else if (_editable == YES){
        return YES;
    }else{
        return NO;
    }
}

- (void)setShowBorder:(BOOL)showBorder{
    _showBorder = showBorder;
}

- (BOOL)showBorder{
    if (_showBorder == NO) {
        return NO;
    }
    else if (_showBorder == YES){
        return YES;
    }else{
        return NO;
    } 
}
- (UIColor *)textColor{
    if (_textColor) {
        return _textColor;
    }
    return [UIColor blackColor];
}

- (void)setBorderColor:(UIColor *)borderColor{
    if (!self.showBorder) {
        _borderColor = [UIColor clearColor];
    }else{
        _borderColor = borderColor;
    }
}

- (UIColor *)borderColor{
    return _borderColor;
}

- (void)setBackGroundColor:(UIColor *)backGroundColor{
    _backGroundColor = backGroundColor;
}

- (UIColor *)backGroundColor{
    if (_backGroundColor != nil) {
        return _backGroundColor;
    }else if (self.editable){
        return [UIColor whiteColor];
    }else{
        return [UIColor clearColor];
    }
}

- (void)setAlpha:(float)alpha{
    _alpha = alpha;
}

- (float)alpha{
    if (0<=_alpha||_alpha<=1) {
        return _alpha;
    }
    return 1.0;
}
- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
}

- (UIFont *)textFont{
    if (!_textFont)
        return [UIFont systemFontOfSize:16];
    return _textFont;

}

+ (id)createViewWith:(HNYDetailItemModel *)itemVO andTarget:(id)target{
    if (itemVO.viewType == TextView) {
        UITextView *textView = [[UITextView alloc] init];
        textView.editable = itemVO.editable;
        textView.textAlignment = itemVO.textAlignment;
        textView.backgroundColor = itemVO.backGroundColor;
        textView.text = itemVO.textValue;
        textView.delegate = target;
        textView.font = itemVO.textFont;
        textView.textColor = itemVO.textColor;
        textView.returnKeyType = itemVO.returnKeyType;
        textView.keyboardType = itemVO.keyboardType;
        return textView;
    }
    else if (itemVO.viewType == TextField) {
        UITextField *textField = [[HNYTextField alloc] init];
        textField.enabled = itemVO.editable;
        textField.textAlignment = itemVO.textAlignment;
        textField.backgroundColor = itemVO.backGroundColor;
        textField.text = itemVO.textValue;
        textField.delegate = target;
        textField.secureTextEntry = itemVO.secureTextEntry;
        textField.font = itemVO.textFont;
        textField.textColor = itemVO.textColor;
        textField.returnKeyType = itemVO.returnKeyType;
        textField.keyboardType = itemVO.keyboardType;
        textField.placeholder = itemVO.placeholder;
        return textField;
    }
    else if (itemVO.viewType == CustomTextView){
//        EXCustomTextView *textView = [[EXCustomTextView alloc ] init];
//        textView.font = [UIFont systemFontOfSize: itemVO.fontSize];
//        textView.textColor = itemVO.textColor;
//        textView.editable = itemVO.editable;
//        if (itemVO.editable == NO)
//            textView.delegate = nil;
//        textView.backgroundColor = itemVO.backGroundColor;
//        textView.textDelegate = target;
//        textView.addressParam = itemVO.params;
//        textView.dataAry = itemVO.value;
//        return textView;
    }
    else if (itemVO.viewType == IPCustomTextView){
//        EXIPCustomTextView *textView = [[EXIPCustomTextView alloc ] init];
//        textView.font = [UIFont systemFontOfSize: itemVO.fontSize];
//        textView.textColor = itemVO.textColor;
//        textView.editable = itemVO.editable;
//        textView.container = itemVO.container;
//        if (itemVO.editable == NO)
//            textView.delegate = nil;
//        textView.backgroundColor = itemVO.backGroundColor;
//        textView.textDelegate = target;
//        textView.addressParam = itemVO.params;
//        textView.dataAry = itemVO.value;
//        return textView;
        
    }
    else if (itemVO.viewType == WebView){
        UIWebView *webView = [[UIWebView alloc] init];
        [webView loadHTMLString:itemVO.value baseURL:nil];
        webView.opaque = NO;
        webView.backgroundColor = itemVO.backGroundColor;
        return  webView;
    }
    else if (itemVO.viewType == InnerMailAttachmentPreviewVC){
//        EXInnerMailAttachmentPreviewVC *attachmentView = [[EXInnerMailAttachmentPreviewVC alloc] init];
//        attachmentView.fileId = itemVO.value;
//        attachmentView.toolbarStyle = PDFToolbarStyle_iPad;
//        attachmentView.serviceName = itemVO.serviceName;
//        attachmentView.fileIdKey = itemVO.key;
//        [target addChildViewController:attachmentView];
//        return attachmentView.view;
    }
    else if (itemVO.viewType == OpinionRelayTableViewController){
//        EXOpinionRelayTableViewController *controller = [[EXOpinionRelayTableViewController alloc] init];
//        controller.serviceName = itemVO.serviceName;
//        controller.voName = itemVO.voName;
//        controller.param = itemVO.params;
//        controller.nameLabelWidth = itemVO.nameLabelWidth;
//        controller.cardDelegate = target;
//        controller.relayListAry = itemVO.value;
//        [target addChildViewController:controller];
//        return controller.view;
    }
    else if (itemVO.viewType == DropDownListPopoverDate){
//        EXDropDownListPopover *popover = [[EXDropDownListPopover alloc] init];
//        popover.popoverType = EXFormPopoverDate;
//        popover.isEditable = itemVO.editable;
//        popover.delegate = target;
//        popover.backgroundColor = itemVO.backGroundColor;
//        popover.font =[UIFont systemFontOfSize: itemVO.fontSize];
//        popover.borderColor = itemVO.borderColor;
//        popover.dateDataFormat = itemVO.dateDataFormat;
//        popover.dateShowFormat = itemVO.dateShowFormat;
//        [popover setData:itemVO.value andText:itemVO.textValue];
//        popover.userInteractionEnabled = YES;
//        return popover;
    }
    else if (itemVO.viewType == DropDownListPopoverComBox){
//        EXDropDownListPopover *popover = [[EXDropDownListPopover alloc] init];
//        popover.popoverType = EXFormPopoverComboBox;
//        popover.isEditable = itemVO.editable;
//        popover.delegate = target;
//        popover.backgroundColor = itemVO.backGroundColor;
//        popover.font =[UIFont systemFontOfSize: itemVO.fontSize];
//        popover.borderColor = itemVO.borderColor;
//        popover.userInteractionEnabled = YES;
//        [popover setData:itemVO.value andText:itemVO.textValue];
//        popover.backgroundColor = itemVO.backGroundColor;
//        if ([itemVO.dataSource isKindOfClass:[NSDictionary class]]) {
//            NSArray *textAry = [[itemVO.dataSource objectForKey:@"key"] copy];
//            NSArray *valeAry = [[itemVO.dataSource objectForKey:@"value"] copy];
//            if (textAry.count == valeAry.count) {
//                [popover resetTextArray:textAry valueArray:valeAry];;
//            }
//        }
//        return popover;
    }
    else if (itemVO.viewType == MultiFunctionTextViewDate) {
//        EXMultiFunctionTextView *popover = [[EXMultiFunctionTextView alloc] init];
//        popover.borderColor = itemVO.borderColor;
//        popover.useCustomStyle = YES;
//        popover.dateDataFormat= itemVO.dateDataFormat;
//        popover.dateShowFormat= itemVO.dateShowFormat;
//        popover.type = EXFormPopoverDate;
//        popover.font =[UIFont systemFontOfSize: itemVO.fontSize];
//        popover.valueChangeDelegate = target;
//        popover.backgroundColor = itemVO.backGroundColor;
//        popover.layer.borderWidth = 1;
//        popover.userInteractionEnabled = YES;
//        popover.editable = itemVO.editable;
//        [popover setOptionName:itemVO.textValue];
//        [popover setControlValue:itemVO.value];
//        return popover;
//
    }
    else if (itemVO.viewType == MultiFunctionTextViewComBox){
//        EXMultiFunctionTextView *popover = [[EXMultiFunctionTextView alloc] init];
//        popover.borderColor = itemVO.borderColor;
//        popover.useCustomStyle = YES;
//        popover.type = EXFormPopoverComboBox;
//        popover.editable = itemVO.editable;
//        popover.font =[UIFont systemFontOfSize: itemVO.fontSize];
//        popover.backgroundColor = itemVO.backGroundColor;
//        popover.valueChangeDelegate = target;
//        popover.userInteractionEnabled = YES;
//        [popover setOptionName:itemVO.textValue];
//        [popover setControlValue:itemVO.value];
//        if ([itemVO.dataSource isKindOfClass:[NSDictionary class]]) {
//            NSArray *textAry = [[itemVO.dataSource objectForKey:@"key"] copy];
//            NSArray *valeAry = [[itemVO.dataSource objectForKey:@"value"] copy];
//            if (textAry.count == valeAry.count) {
//                [popover resetTextArray:textAry valueArray:valeAry];
//                [popover resetWithTextArray:textAry valueArray:valeAry];
//            }
//        }
//        return popover;
        
    }

    else if (itemVO.viewType == Label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = itemVO.textAlignment;
        label.backgroundColor = itemVO.backGroundColor;
        label.text = itemVO.textValue;
        label.font = itemVO.textFont;
        label.textColor = itemVO.textColor;
        label.numberOfLines = 0;
        return label;
    }
    else if (itemVO.viewType == ImageView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = itemVO.backGroundColor;
        imgView.contentMode = itemVO.contentMode;
        if ([itemVO.value isKindOfClass:[NSURL class]]) {
            [imgView setImageWithURL:itemVO.value];
        }
        else if ([itemVO.value isKindOfClass:[UIImage class]]){
            [imgView setImage:itemVO.value];
        }
        return imgView;
    }
    else if (itemVO.viewType == Switch) {
        UISwitch *switchControl = [[UISwitch alloc] init];
        switchControl.userInteractionEnabled = itemVO.editable;
        switchControl.on = [itemVO.value boolValue];
        switchControl.onTintColor = itemVO.backGroundColor;
        [switchControl addTarget:target action:@selector(touchSwitchButton:) forControlEvents:UIControlEventValueChanged];
        return switchControl;
    }
   else  if (itemVO.viewType == CustomerDropDownTable) {
//        EXCustomerDropDownTable *table = [[EXCustomerDropDownTable alloc] init];
//        table.title = itemVO.title;
//        table.nameKey = itemVO.dateShowFormat;
//        table.idKey = itemVO.dateDataFormat;
//        table.serviceName = itemVO.serviceName;
//        table.param = itemVO.params;
//        table.returnDic = YES;
//        table.custDelegate = target;
//        table.backgroundColor = itemVO.backGroundColor;
//        table.font = [UIFont systemFontOfSize:itemVO.fontSize];
//        table.editable = itemVO.editable;
//        table.text = itemVO.textValue;
//        if ([itemVO.dataSource isKindOfClass:[NSDictionary class]]) {
//            NSArray *textAry = [[itemVO.dataSource objectForKey:@"key"] copy];
//            NSArray *valeAry = [[itemVO.dataSource objectForKey:@"value"] copy];
//            if (textAry.count == valeAry.count) {
//                table.idValueAry = valeAry;
//                table.nameValueAry = textAry;
//            }
//        }
//        return table;
    }
    else if (itemVO.viewType == CustomerChoiceView) {
//        EXCustomerChoiceView *choiceView = [[EXCustomerChoiceView alloc] init];
//        choiceView.serviceName = itemVO.serviceName;
//        choiceView.nameKey = itemVO.dateShowFormat;
//        choiceView.valueKey = itemVO.dateDataFormat;
//        choiceView.dataList = itemVO.dataSource;
//        choiceView.singleChoice = itemVO.style;
//        choiceView.param = itemVO.params;
//        choiceView.itemHeight = itemVO.viewSize.height;
//        choiceView.itemWidth = itemVO.viewSize.width;
//        choiceView.delegate = target;
//        return choiceView;
    }
    return nil;
}
#pragma mark - IBAction
- (void)touchSwitchButton:(UIButton*)sender{
    
}

@end

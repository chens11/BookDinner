//
//  HNYDetailTableViewController.m
//  exoa_mobile
//
//  Created by chenzq on 5/14/13.
//
//

#import "HNYDetailTableViewController.h"
#import "PublicDefine.h"

@interface HNYDetailTableViewController ()
@property (nonatomic, assign) CGFloat totalCellHeight;
@property (nonatomic, strong) NSMutableArray  *views;
@property (nonatomic, strong) NSMutableArray *keys;
- (void)changeViewAryWith:(id)value inIndex:(NSInteger)index;

@end

@implementation HNYDetailTableViewController
@synthesize backGroundColor = _backGroundColor;
@synthesize separatorLineColor = _separatorLineColor;
@synthesize cellBackGroundColor = _cellBackGroundColor;
@synthesize viewAry = _viewAry;
@synthesize valueDic = _valueDic;
@synthesize cellHeight = _cellHeight;
@synthesize totalCellHeight = _totalCellHeight;
@synthesize nameTextColor = _nameTextColor;
@synthesize nameTextFont = _nameTextFont;
@synthesize valueTextFont = _valueTextFont;
@synthesize valueTextColor = _valueTextColor;
@synthesize delegate = _delegate;
@synthesize customDelegate = _customDelegate;
@synthesize nameLabelWidth;
@synthesize views;
#pragma mark - view lifecycle
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];

    if (self) {
        // Custom initialization
        self.totalCellHeight = 0;
        self.nameTextAlignment = NSTextAlignmentRight;
        self.nameTextFont = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        self.nameTextColor = [UIColor blackColor];
        self.valueTextFont = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        self.valueTextColor = [UIColor blackColor];
        self.cellHeight = 40.0;
        self.nameLabelWidth = 80.0;
        self.cellBackGroundColor = [UIColor colorWithRed:240.0 / 255 green:240.0 / 255 blue:240.0 / 255 alpha:1.0];
        self.separatorLineColor = [UIColor colorWithRed:204.0 / 255 green:204.0 / 255 blue:204.0 / 255 alpha:1.0];
        self.valueDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    self.tableView.separatorColor = self.separatorLineColor;
}

- (BOOL)disablesAutomaticKeyboardDismissal{
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ((textView.returnKeyType == UIReturnKeyDone) && [text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:textView.tag];

    itemVo.value = textView.text;
    itemVo.textValue = textView.text;
    [self changeViewAryWith:textView.text inIndex:textView.tag];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:textField.tag];
    
    itemVo.value = textField.text;
    itemVo.textValue = textField.text;
    [self changeViewAryWith:textField.text inIndex:textField.tag];

}


#pragma mark -  EXFormPopoverLabelExtDelegate

//- (void)popoverLabel:(EXFormPopoverLabelExt *)popoverLabel dataChangeWithValue:(NSString *)value text:(NSString *)text
//{
//    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:popoverLabel.tag];
//
//    itemVo.value = value;
//    [self changeViewAryWith:value inIndex:popoverLabel.tag];
//}
//
//- (void)popoverLabel:(EXFormPopoverLabelExt *)popoverLabel dateChangeWithDateString:(NSString *)dateStr
//{
//    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:popoverLabel.tag];
//
//    itemVo.value = dateStr;
//    itemVo.textValue = dateStr;
//
//    [self changeViewAryWith:dateStr inIndex:popoverLabel.tag];
//}
//
//- (void)popoverLabelEndEditing:(EXFormPopoverLabelExt *)popoverLabel
//{
//    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:popoverLabel.tag];
//
//    itemVo.value = [popoverLabel getValue];
//    [self changeViewAryWith:[popoverLabel getValue] inIndex:popoverLabel.tag];
//}

#pragma mark - EXCardDelegate

//- (void)viewController:(UIViewController *)aViewController activeWithOperationInfomation:(NSDictionary *)info
//{
//    if ([aViewController isKindOfClass:[EXOpinionRelayTableViewController class]]) {
//        if ([_cardDelegate respondsToSelector:@selector(viewController:activeWithOperationInfomation:)]) {
//            if ([aViewController isKindOfClass:[EXOpinionRelayTableViewController class]]) {
//                NSMutableDictionary *message = [NSMutableDictionary dictionaryWithDictionary:info];
//                [message setObject:@"customerAction" forKey:@"operation"];
//                [self.cardDelegate viewController:self activeWithOperationInfomation:message];
//            }
//        }
//    } else if ([aViewController isKindOfClass:[EXIPCustomTextView class]]) {
//        EXIPCustomTextView *textView = (EXIPCustomTextView *)aViewController;
//        HNYDetailItemModel *itemVO = [self.viewAry objectAtIndex:textView.tag];
//
//        NSArray *array = [info objectForKey:@"value"];
//        NSMutableString *text = [[NSMutableString alloc] initWithString:@""];
//
//        if (array.count > 0) {
//            for (int j = 0; j < array.count; j++) {
//                EXPersonList *person = [array objectAtIndex:j];
//
//                if (text.length != 0) {
//                    [text appendString:@";"];
//                }
//
//                [text appendString:person.name];
//            }
//        }
//
//        itemVO.value = array;
//        itemVO.textValue = text;
//        [self changeViewAryWith:array inIndex:textView.tag];
//    } else if ([aViewController isKindOfClass:[EXCustomTextView class]]) {
//        EXCustomTextView *textView = (EXCustomTextView *)aViewController;
//        HNYDetailItemModel *itemVO = [self.viewAry objectAtIndex:textView.tag];
//
//        NSArray *array = [info objectForKey:@"value"];
//        NSMutableString *text = [[NSMutableString alloc] initWithString:@""];
//
//        if (array.count > 0) {
//            for (int j = 0; j < array.count; j++) {
//                EXPersonList *person = [array objectAtIndex:j];
//
//                if (text.length != 0) {
//                    [text appendString:@";"];
//                }
//
//                [text appendString:person.name];
//            }
//        }
//
//        itemVO.value = array;
//        itemVO.textValue = text;
//        [self changeViewAryWith:array inIndex:textView.tag];
//    }
//}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.customDelegate respondsToSelector:@selector(tableViewController:didSelectRowAtIndexPath:)])
        [self.customDelegate tableViewController:self didSelectRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _viewAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%f",_totalCellHeight);
    CGFloat height = self.cellHeight;
    HNYDetailItemModel *itemVO = [self.viewAry objectAtIndex:indexPath.row];



    if ((itemVO.height == nil) && (itemVO.textValue != nil)) {
        CGSize size = [itemVO.textValue sizeWithFont:[UIFont systemFontOfSize:(self.valueTextFont.pointSize + 6)] constrainedToSize:CGSizeMake(self.view.frame.size.width - self.nameLabelWidth, 100) lineBreakMode:NSLineBreakByWordWrapping];

        if (height < size.height) {
            height = size.height;
        }

        self.totalCellHeight += height;
        return height;
    }

    else if ([itemVO.height isEqualToString:@"cellHeight/2"]) {
        self.totalCellHeight += height / 2;
        return height / 2;
    }

    else if ([itemVO.height isEqualToString:@"one"]) {
        self.totalCellHeight += height;
        return height;
    }

    else if ([itemVO.height isEqualToString:@"two"]) {
        self.totalCellHeight += height * 2;
        return height * 2;
    }

    else if ([itemVO.height isEqualToString:@"three"]) {
        self.totalCellHeight += height * 3;
        return height * 3;
    }

    else if ([itemVO.height isEqualToString:@"four"]) {
        self.totalCellHeight += height * 4;
        return height * 4;
    }

    else if ([itemVO.height isEqualToString:@"five"]) {
        self.totalCellHeight += height * 5;
        return height * 5;
    }

    else if ([itemVO.height isEqualToString:@"six"]) {
        self.totalCellHeight += height * 6;
        return height * 6;
    }

    else if ([itemVO.height isEqualToString:@"1/3"]) {
        height = (self.view.frame.size.height - _totalCellHeight) / 3;
        self.totalCellHeight += height;
        return height;
    }

    else if ([itemVO.height isEqualToString:@"2/3"]) {
        height = (self.view.frame.size.height - _totalCellHeight) * 2 / 3;
        self.totalCellHeight += height;
        return height;
    }

    else if ([itemVO.height isEqualToString:@"3/4"]) {
        height = (self.view.frame.size.height - _totalCellHeight) * 3 / 4;
        self.totalCellHeight += height;
        return height;
    }

    else if ([itemVO.height isEqualToString:@"1/2"]) {
        height = (self.view.frame.size.height - _totalCellHeight) / 2;
        self.totalCellHeight += height;
        return height;
    }

    else if ([itemVO.height isEqualToString:@"1/1"]) {
        height = self.view.frame.size.height - _totalCellHeight;
        self.totalCellHeight = 0;
        return height;
    }
    else if ([itemVO.height isEqualToString:@"auto"]) {
        CGSize size = [itemVO.textValue sizeWithFont:[UIFont systemFontOfSize:(self.valueTextFont.pointSize + 6)] constrainedToSize:CGSizeMake(self.view.frame.size.width - self.nameLabelWidth, itemVO.maxheight) lineBreakMode:NSLineBreakByWordWrapping];
        
        height = size.height;
        if (height < itemVO.minheight) {
            height = itemVO.minheight;
        }
        else if (height > itemVO.maxheight) {
            height = itemVO.maxheight;
        }

        self.totalCellHeight += height;
        return height;
    }

    self.totalCellHeight += height;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"UITableViewCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];

    for (UIView *subView in [cell.contentView subviews] ) {
        [subView removeFromSuperview];
    }
    id object = [self.views objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = self.cellBackGroundColor;

    HNYDetailItemModel *itemVO = [self.viewAry objectAtIndex:indexPath.row];
    itemVO.tag = indexPath.row;
    itemVO.nameLabelWidth = self.nameLabelWidth;

    if ((itemVO.value != nil) && (itemVO.key != nil)) {
        [_valueDic setObject:itemVO.value forKey:itemVO.key];
    }
    cell.accessoryType = itemVO.accessoryType;

    {
        UILabel *starLabel = [[UILabel alloc] init];
        starLabel.textAlignment = NSTextAlignmentCenter;
        starLabel.frame = CGRectMake(5, 6, 15, cell.frame.size.height);
        starLabel.font = [UIFont systemFontOfSize:30];
        starLabel.textAlignment = NSTextAlignmentRight;
        starLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        starLabel.textColor = [UIColor redColor];
        starLabel.backgroundColor = [UIColor clearColor];
        if (itemVO.required){
            starLabel.text = [NSString stringWithFormat:@"*"];
        }else{
            starLabel = nil;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = self.nameTextAlignment;
        label.frame = CGRectMake(starLabel.frame.size.width, 0, self.nameLabelWidth - starLabel.frame.size.width, cell.frame.size.height);
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.numberOfLines = 2;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.font = self.nameTextFont;
        label.textColor = self.nameTextColor;
        label.backgroundColor = [UIColor clearColor];
        label.text = itemVO.name;

        if (itemVO.name == nil) {
            label = [[UILabel alloc] init];
            starLabel = [[UILabel alloc] init];
        }

        UIView *view = object;
        view.tag = indexPath.row;
        view.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);

        if (itemVO.viewType == Switch) {
            view.frame = CGRectMake(label.frame.size.width + label.frame.origin.x + 15, (cell.frame.size.height - view.frame.size.height) / 2, view.frame.size.width - itemVO.rightPadding, cell.frame.size.height);
        }
        else {
            view.frame = CGRectMake(label.frame.size.width + label.frame.origin.x, 0, cell.frame.size.width - label.frame.size.width - label.frame.origin.x  - itemVO.rightPadding, cell.frame.size.height);
        }

        [cell.contentView addSubview:starLabel];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:view];
    }
    return cell;
}

#pragma mark - instance fun
- (void)setViewAry:(NSArray *)viewAry{
    self.views = [NSMutableArray arrayWithCapacity:0];
    self.keys = [NSMutableArray arrayWithCapacity:0];
    for (HNYDetailItemModel *itemVO in viewAry) {
        NSInteger index = [viewAry indexOfObject:itemVO];
        itemVO.tag = index;
        [self.keys addObject:itemVO.key];
        if (itemVO.viewType == Customer) {
            [self.views addObject:[self.customDelegate createViewWith:itemVO]];
        }else{
            [self.views addObject:[HNYDetailItemModel createViewWith:itemVO andTarget:self]];
        }
        
    }
    _viewAry = viewAry;
}

- (void)changeViewAryWith:(id)value inIndex:(NSInteger)index
{
    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:index];

    if ((itemVo.key != nil) && (itemVo.value != nil)) {
        [self.valueDic setObject:itemVo.value forKey:itemVo.key];

        if ([self.customDelegate respondsToSelector:@selector(valueDicChange:withValue:andKey:)]) {
            [self.customDelegate valueDicChange:self withValue:value andKey:itemVo.key];
        }
    }
}

- (void)changeViewAryObjectWith:(HNYDetailItemModel *)item atIndex:(NSInteger)index
{
    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:index];

    itemVo.value = item.value;
    itemVo.tag = item.tag;
    itemVo.textValue = item.textValue;

    if (itemVo.viewType == Customer) {
        [self.views replaceObjectAtIndex:index withObject:[self.customDelegate createViewWith:itemVo]];
    }else{
        [self.views replaceObjectAtIndex:index withObject:[HNYDetailItemModel createViewWith:itemVo andTarget:self]];
    }

    if ((itemVo.key != nil) && (itemVo.value != nil)) {
        [self.valueDic setObject:itemVo.value forKey:itemVo.key];

        if ([self.customDelegate respondsToSelector:@selector(valueDicChange:withValue:andKey:)]) {
            [self.customDelegate valueDicChange:self withValue:itemVo.value andKey:itemVo.key];
        }
    }
    [self.tableView reloadData];
}

// 隐藏键盘
- (void)viewTapped:(UITapGestureRecognizer *)tapGr
{
    [self.view endEditing:YES];
}

- (HNYDetailItemModel *)getItemWithKey:(NSString *)key{
    NSInteger index = [self.keys indexOfObject:key];
    if (index < _viewAry.count) {
        return [_viewAry objectAtIndex:index];
    }
    return nil;
}

#pragma mark - UISwitch Action
- (void)touchSwitchButton:(UISwitch *)control
{
    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:control.tag];

    itemVo.value = [NSNumber numberWithBool:control.on];
    [self changeViewAryWith:itemVo.value inIndex:control.tag];
}

#pragma mark - EXMultiFunctionTextViewDelegate

//- (void)textView:(EXMultiFunctionTextView *)textView valueChanged:(NSString *)value
//{
//    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:textView.tag];
//
//    itemVo.value = value;
//    [self changeViewAryWith:value inIndex:textView.tag];
//}
//
#pragma mark - EXCustomerDropDownTableDelegate

//- (void)dropDownTable:(EXCustomerDropDownTable *)dropDownTable valueChange:(id)value
//{
//    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:dropDownTable.tag];
//
//    itemVo.value = value;
//    [self changeViewAryWith:itemVo.value inIndex:dropDownTable.tag];
//}

#pragma mark - EXCustomerChoiceViewDelegate
//- (void)customerChoiceView:(EXCustomerChoiceView *)choiceView choiceAtIndex:(int)index
//{
//    HNYDetailItemModel *itemVo = [self.viewAry objectAtIndex:choiceView.tag];
//
//    if ([choiceView.singleChoice boolValue]) {
//        itemVo.value = [choiceView.dataList objectAtIndex:index];
//    } else {
//        itemVo.value = choiceView.dataList;
//    }
//
//    [self changeViewAryWith:itemVo.value inIndex:choiceView.tag];
//}
@end


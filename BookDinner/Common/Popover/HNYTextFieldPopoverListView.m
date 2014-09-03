//
//  HNYTextFieldPopoverListView.m
//  BookDinner
//
//  Created by chenzq on 8/27/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTextFieldPopoverListView.h"

@implementation HNYTextFieldPopoverListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}
#pragma mark - HNYPopoverViewDelegate
// caled when select the String ary
- (void)hNYPopoverView:(HNYPopoverView *)popover didSelectStringAryAtIndex:(NSInteger)index{
//    HNYDetailItemModel *item = [self.tableViewController getItemWithKey:USER_SEX];
//    item.textValue = [self.sexAry objectAtIndex:index];
//    item.value = [NSString stringWithFormat:@"%d",index];
//    [self.tableViewController.tableView reloadData];
//    [popover dismissPopoverAnimated:YES];
}


@end

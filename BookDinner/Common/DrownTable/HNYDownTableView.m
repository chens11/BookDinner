//
//  HNYDownTableView.m
//  VillageEducation
//
//  Created by chenzq on 4/24/14.
//  Copyright (c) 2014 hubei. All rights reserved.
//

#import "HNYDownTableView.h"
#import "HNYActionSheet.h"
#import "HNYTableView.h"

@interface HNYDownTableView()<UIActionSheetDelegate,HNYTableViewDelegate>
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) HNYActionSheet *sheet;


@end

@implementation HNYDownTableView
@synthesize defaultSelectIndex = _defaultSelectIndex;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        
        self.button  =[UIButton buttonWithType:UIButtonTypeCustom];
        self.button.backgroundColor = [UIColor clearColor];
        [self.button addTarget:self action:@selector(showDrownTable:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.label];
        [self addSubview:self.button];
        
        
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.label.frame = CGRectMake(3, 0, self.frame.size.width - 5 , self.frame.size.height);
}

#pragma mark - ibaciton
- (void)showDrownTable:(UIButton*)sender{
    [self.superview endEditing:YES];
    [sender becomeFirstResponder];
    HNYTableView *tableView = [[HNYTableView alloc] initWithFrame:CGRectMake(0, 0,320, 200) style:UITableViewStylePlain];
    tableView.list = self.list;
    tableView.idKey = self.idKey;
    tableView.nameKey = self.nameKey;
    tableView.defaultSelectIndex = self.defaultSelectIndex;
    tableView.cutDelegate = self;
    
//    self.sheet = [[HNYActionSheet alloc] initWithTitle:@"test" contentView:tableView cancelButtonTitle:@"取消" sureButtonTitle:nil];
//    [self.sheet showFromRect:self.frame inView:[self superview] animated:YES];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
}

#pragma mark - HNYTableViewDelegate
- (void)hnyTableView:(HNYTableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.list.count > indexPath.row) {
        NSDictionary *dictionary = [self.list objectAtIndex:indexPath.row];
        self.label.text = [dictionary objectForKey:self.nameKey];
    }
    if ([self.delegate respondsToSelector:@selector(hnyDownTableView:didSelectIndex:)])
        [self.delegate hnyDownTableView:self didSelectIndex:indexPath.row];
}

- (void)setDefaultSelectIndex:(NSNumber*)defaultSelectIndex{
    _defaultSelectIndex = defaultSelectIndex;
    
    if (defaultSelectIndex && self.list.count > [defaultSelectIndex intValue]) {
        NSDictionary *dictionary = [self.list objectAtIndex:[defaultSelectIndex intValue]];
        self.label.text = [dictionary objectForKey:self.nameKey];
    }
}
#pragma mark - instance fun
- (void)dismissDownTableWithAnimated:(BOOL)animated{
//    [self.sheet dismissWithClickedButtonIndex:0 animated:animated];
}
@end

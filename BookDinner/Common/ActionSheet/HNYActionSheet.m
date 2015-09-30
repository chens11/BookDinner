//
//  HNYActionSheet.m
//  VillageEducation
//
//  Created by chenzq on 4/24/14.
//  Copyright (c) 2014 hubei. All rights reserved.
//

#import "HNYActionSheet.h"

@interface HNYActionSheet()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *titleLine;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *sureButton;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UIButton *buttonClick;
@property (nonatomic,strong) NSArray *stringAry;

@end

@implementation HNYActionSheet

#pragma mark - vies life cycle
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognize:)];
        self.backGroundView = [[UIView alloc] init];
        [self.backGroundView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - Class fun
+ (HNYActionSheet*)showWithTitle:(NSString *)title contentView:(UIView *)cView cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle delegate:(id<HNYActionSheetDelegate>)delegate{
    
    HNYActionSheet *sheet = [[HNYActionSheet alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet showWithTitle:title contentView:cView cancelBtnTitle:cTitle sureBtnTitle:sTitle];
    [sheet show];
    return sheet;
}

+ (HNYActionSheet *)showWithTitle:(NSString *)title withStringAry:(NSArray *)strAry cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle delegate:(id<HNYActionSheetDelegate>)delegate{
    HNYActionSheet *sheet = [[HNYActionSheet alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet showWithTitle:title withStringAry:strAry cancelBtnTitle:cTitle sureBtnTitle:sTitle];
    [sheet show];
    return sheet;
}

#pragma mark - fun the hide and show HNYActionSheet
- (void)hide{
    
    CGRect frame = self.frame;

    if ([self.delegate respondsToSelector:@selector(hNYActionSheet:willDismissWithButtonIndex:)])
        [self.delegate hNYActionSheet:self willDismissWithButtonIndex:0];
    
    [UIView animateWithDuration:0.5f animations:^{
        self.backGroundView.alpha = 0.1f;
        self.frame = CGRectMake(frame.origin.x, [self getTopViewOfTheWindow].frame.size.height, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backGroundView removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(hNYActionSheet:didDismissWithButtonIndex:)])
            [self.delegate hNYActionSheet:self didDismissWithButtonIndex:self.buttonClick.tag];
    }];

}

- (void)show{
    UIView *topView = [self getTopViewOfTheWindow];
    [topView addSubview:self.backGroundView];
    [topView addSubview:self];

    CGRect frame = self.frame;
    frame.origin.y = topView.frame.size.height - self.frame.size.height;
    self.frame = CGRectMake(frame.origin.x, topView.frame.size.height, frame.size.width, frame.size.height);

    if ([self.delegate respondsToSelector:@selector(willPresentHNYActionSheet:)])
        [self.delegate willPresentHNYActionSheet:self];
    
    [UIView animateWithDuration:0.5f animations:^{
        self.backGroundView.alpha = 0.7f;
        self.frame = frame;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(didPresentHNYActionSheet:)]) {
            [self.delegate didPresentHNYActionSheet:self];
        }
    }];

}

#pragma mark  - UITapGestureRecognizer
- (void)tapGestureRecognize:(UITapGestureRecognizer*)gesture{
    self.buttonClick = self.cancelButton;
        [self hide];
}
#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    self.buttonClick = sender;
    if ([self.delegate respondsToSelector:@selector(hNYActionSheet:clickedButtonAtIndex:)]) {
        [self.delegate hNYActionSheet:self clickedButtonAtIndex:sender.tag];
    }
    [self hide];
    
}
#pragma mark - Get tht key Window top view
- (UIView*)getTopViewOfTheWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    return [[window subviews] objectAtIndex:0];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stringAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HNYActionSheetStringAryCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"ActionSheetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.textLabel.text = [self.stringAry objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(hNYActionSheet:didSelectStringAryAtIndex:)]) {
        [self.delegate hNYActionSheet:self didSelectStringAryAtIndex:indexPath.row];
    }
}

#pragma mark - Create SubViews
- (void)showWithTitle:(NSString *)title withStringAry:(NSArray *)strAry cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle{
    self.stringAry = strAry;
    UIView *topView = [self getTopViewOfTheWindow];
    
    float height  = 200;
    if (height > strAry.count * HNYActionSheetStringAryCellHeight)
        height = strAry.count * HNYActionSheetStringAryCellHeight;
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, height) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.tag = 10000000;
    [self showWithTitle:title contentView:table cancelBtnTitle:cTitle sureBtnTitle:sTitle];
}

- (void)showWithTitle:(NSString*)title contentView:(UIView *)cView cancelBtnTitle:(NSString *)cTitle sureBtnTitle:(NSString *)sTitle{
    
    self.contentView = cView;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = title;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
//    self.titleLabel.backgroundColor = [UIColor colorWithRed:239.0/255 green:242.0/255 blue:255.0/255 alpha:1.0];
    
    self.titleLine = [[UILabel alloc] init];
    self.titleLine.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];

    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.tag = 0;
    self.cancelButton.layer.borderWidth = 1;
    self.cancelButton.layer.cornerRadius = 3;
    self.cancelButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.cancelButton setTitle:cTitle forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.cancelButton setBackgroundColor:self.titleLabel.backgroundColor];
    [self.cancelButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureButton.tag = 1;
    self.sureButton.layer.borderWidth = 1;
    self.sureButton.layer.cornerRadius = 3;
    self.sureButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.sureButton setTitle:sTitle forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.sureButton setBackgroundColor:self.titleLabel.backgroundColor];
    [self.sureButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if (title){
        [self addSubview:self.titleLabel];
        [self addSubview:self.titleLine];
    }
    if (cView)
        [self addSubview:self.contentView];
    if (cTitle)
        [self addSubview:self.cancelButton];
    if (sTitle)
        [self addSubview:self.sureButton];
    [self setTheFrame];
}

#pragma mark - set view frame
- (void)setTheFrame{
    
    UIView *topView = [self getTopViewOfTheWindow];
    //设置self 的fram
    self.backGroundView.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    self.backGroundView.layer.opacity = 0.1;
    self.backGroundView.frame = topView.bounds;

    //计算titlLabel frame
    CGSize size = topView.bounds.size;
    CGSize titleLabelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    if (titleLabelSize.height < HNYActionSheetButtonHeight)
        titleLabelSize.height = HNYActionSheetButtonHeight;
    self.titleLabel.frame = CGRectMake(0, 0, size.width, titleLabelSize.height);
    self.titleLine.frame = CGRectMake(0, titleLabelSize.height - 1, size.width, 1);
    
    CGFloat height = self.titleLabel.frame.size.height;
    if (!self.titleLabel.text)
        height -= height;
    
    self.contentView.frame = CGRectMake(0, height, size.width, self.contentView.frame.size.height);
    height += self.contentView.frame.size.height;
    
    if (self.sureButton.titleLabel.text) {
        self.sureButton.frame = CGRectMake(size.width/2-1, height, size.width/2+2, HNYActionSheetButtonHeight + 1);
        self.cancelButton.frame = CGRectMake(-1, height, size.width/2+2, HNYActionSheetButtonHeight + 1);
        height += HNYActionSheetButtonHeight;
    }
    else if (self.cancelButton.titleLabel.text){
        self.cancelButton.frame = CGRectMake(-1, height, size.width+2, HNYActionSheetButtonHeight + 1);
        height += HNYActionSheetButtonHeight;
    }
    
    self.frame = CGRectMake(0, size.height - height, size.width, height);

}

@end

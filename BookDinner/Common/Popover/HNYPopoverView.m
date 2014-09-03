//
//  HNYPopoverView.m
//  Demo
//
//  Created by chenzq on 4/18/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYPopoverView.h"
@interface HNYPopoverView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic) CGPoint arrowPoint;
@property (nonatomic) BOOL above;
@property (nonatomic) CGRect contentRect;
@property (nonatomic,strong) NSArray *stringAry;

@end

@implementation HNYPopoverView

#pragma mark - vies life cycle
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.above = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognize:)];
        self.backGroundView = [[UIView alloc] init];
        self.backGroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backGroundView];
        [self.backGroundView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat minx = CGRectGetMinX(self.contentRect);
    CGFloat maxx = CGRectGetMaxX(self.contentRect);
    CGFloat miny = CGRectGetMinY(self.contentRect);
    CGFloat maxy = CGRectGetMaxY(self.contentRect);
    CGFloat radius = HNYPopoverViewCornerRadius;
    CGFloat arrowOffset = HNYArrowOffset;
    CGFloat arrowHeight = HNYArrowHeight;
    //创建path
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加圆到path
    [path moveToPoint:CGPointMake(minx, miny + radius)];
    [path addCurveToPoint:CGPointMake(minx + radius, miny) controlPoint1:CGPointMake(minx, miny + radius - arrowOffset) controlPoint2:CGPointMake(minx + radius - arrowOffset, miny)];

    if (!self.above) {
        [path addLineToPoint:CGPointMake(self.arrowPoint.x - arrowHeight, miny)];
        [path addCurveToPoint:self.arrowPoint controlPoint1:CGPointMake(self.arrowPoint.x - arrowHeight + arrowOffset, miny) controlPoint2:CGPointMake(self.arrowPoint.x, self.arrowPoint.y + arrowOffset)];
        [path addCurveToPoint:CGPointMake(self.arrowPoint.x + arrowHeight, miny) controlPoint1:CGPointMake(self.arrowPoint.x, self.arrowPoint.y + arrowOffset) controlPoint2:CGPointMake(self.arrowPoint.x + arrowHeight - arrowOffset, miny)];
    }
    [path addLineToPoint:CGPointMake(maxx - radius, miny)];
    [path addCurveToPoint:CGPointMake(maxx, miny + radius) controlPoint1:CGPointMake(maxx - radius + arrowOffset, miny) controlPoint2:CGPointMake(maxx, miny + radius - arrowOffset)];

    [path addLineToPoint:CGPointMake(maxx, maxy - radius)];
    [path addCurveToPoint:CGPointMake(maxx - radius, maxy) controlPoint1:CGPointMake(maxx, maxy - radius + arrowOffset) controlPoint2:CGPointMake(maxx - radius + arrowOffset, maxy)];

    if (self.above) {
        [path addLineToPoint:CGPointMake(self.arrowPoint.x + arrowHeight, maxy)];
        [path addCurveToPoint:self.arrowPoint controlPoint1:CGPointMake(self.arrowPoint.x + arrowHeight - arrowOffset,maxy) controlPoint2:CGPointMake(self.arrowPoint.x, self.arrowPoint.y - arrowOffset)];
        [path addCurveToPoint:CGPointMake(self.arrowPoint.x - arrowHeight, maxy) controlPoint1:CGPointMake(self.arrowPoint.x, self.arrowPoint.y - arrowOffset) controlPoint2:CGPointMake(self.arrowPoint.x - arrowHeight + arrowOffset, maxy)];
    }
    [path addLineToPoint:CGPointMake(minx + radius, maxy)];
    [path addCurveToPoint:CGPointMake(minx, maxy - radius) controlPoint1:CGPointMake(minx + radius - arrowOffset, maxy) controlPoint2:CGPointMake(minx, maxy - radius + arrowOffset)];

    [path addLineToPoint:CGPointMake(minx, miny + radius)];

    // 设置描边宽度（为了让描边看上去更清楚）
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    [[UIColor clearColor] setStroke];
    [[UIColor colorWithWhite:0.8 alpha:1.0] setFill];
    // 描边和填充
    [path stroke];
    [path fill];
    
    if (self.titleLabel) {
        UIBezierPath *bottomTitleLine = [UIBezierPath bezierPath];
        [bottomTitleLine moveToPoint:CGPointMake(minx, miny + self.titleLabel.frame.size.height)];
        [bottomTitleLine addLineToPoint:CGPointMake(maxx, miny + self.titleLabel.frame.size.height)];
        [bottomTitleLine setLineWidth:0.2];
        [[UIColor blackColor] setStroke];
        [bottomTitleLine stroke];
    }
}
#pragma mark - Class Static presenting Method

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentPopoverFromRect:rect inView:view withTitle:nil withText:text];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentPopoverFromRect:rect inView:view withTitle:title withText:text];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentPopoverFromRect:rect inView:view withTitle:nil withContentView:cView];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentPopoverFromRect:rect inView:view withTitle:title withContentView:cView];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view  withStringAry:(NSArray*)strAry delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentPopoverFromRect:rect inView:view withTitle:nil withStringAry:strAry];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

+ (HNYPopoverView *)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withStringAry:(NSArray*)strAry delegate:(id<HNYPopoverViewDelegate>)delegate{
    HNYPopoverView *sheet = [[HNYPopoverView alloc] initWithFrame:CGRectZero];
    sheet.delegate = delegate;
    [sheet presentPopoverFromRect:rect inView:view withTitle:title withStringAry:strAry];
    [sheet presentPopoverAnimated:YES];
    return sheet;
}

#pragma mark - Instance presenting Methods

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withStringAry:(NSArray *)strAry{
    [self presentPopoverFromRect:rect inView:view withTitle:nil withStringAry:strAry];
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withStringAry:(NSArray *)strAry{

    self.stringAry = strAry;
    UIView *topView = [self getTopViewOfTheWindow];
    
    float height  = 200;
    if (height > strAry.count * HNYPopoverViewStringAryCellHeight)
        height = strAry.count * HNYPopoverViewStringAryCellHeight;
    CGSize size = CGSizeZero;

    for (NSString *string in self.stringAry) {
        CGSize strSize = [string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(topView.frame.size.width - 60, HNYPopoverViewStringAryCellHeight) lineBreakMode:NSLineBreakByWordWrapping];
        strSize.width += 60;
        if (strSize.width > size.width)
            size.width = strSize.width;
    }

    if (topView.frame.size.width - 60 < size.width) {
        size.width = topView.frame.size.width - 60;
    }
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, height) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    table.tag = 10000000;

    [self presentPopoverFromRect:rect inView:view withTitle:title withContentView:table];
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withText:(NSString *)text{
    [self presentPopoverFromRect:rect inView:view withTitle:nil withText:text];
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text {
    UIView *topView = [self getTopViewOfTheWindow];
    float font = HNYPopoverViewTextFont;
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:font + 2] constrainedToSize:CGSizeMake(topView.frame.size.width - 40, topView.frame.size.height *4/5) lineBreakMode:NSLineBreakByWordWrapping];
    if (size.height < 44)
        size.height = 44;
    if (size.width < topView.frame.size.width - 40) {
        size.width = topView.frame.size.width - 40;
    }
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    textView.text = text;
    float offset = (textView.frame.size.height - textView.contentSize.height)/2;
    textView.contentInset = UIEdgeInsetsMake(offset, 0, offset, 0);
    textView.textAlignment = NSTextAlignmentCenter;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:font];
    textView.editable = NO;
    if (!text)
        textView = nil;
    [self presentPopoverFromRect:rect inView:view withTitle:title withContentView:textView];
}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView {
    
    UIView *topView = [self getTopViewOfTheWindow];
    float font = HNYPopoverViewTextFont;
    CGSize size = CGSizeZero;
    if (cView) {
        size = [title sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(cView.frame.size.width,44) lineBreakMode:NSLineBreakByWordWrapping];
        if (size.width < cView.frame.size.width)
            size.width = cView.frame.size.width;
        if (size.height < 44)
            size.height =44;
    }
    else{
        size = [title sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(topView.frame.size.width - 40, topView.frame.size.height *4/5) lineBreakMode:NSLineBreakByWordWrapping];
        if (size.width < topView.frame.size.width - 40)
            size.width = topView.frame.size.width - 40;
        if (size.height < 44)
            size.height = 44;
    }
    if (size.width < cView.frame.size.width)
        size.width = cView.frame.size.width;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.font = [UIFont systemFontOfSize:font];
    if (!title)
        titleLabel = nil;
    
    cView.frame = CGRectMake(0, titleLabel.frame.size.height, cView.frame.size.width, cView.frame.size.height);
    UIView *containtView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, titleLabel.frame.size.height + cView.frame.size.height)];
    
    if (titleLabel){
        self.titleLabel = titleLabel;
        [containtView addSubview:titleLabel];
    }
    if (cView)
        [containtView addSubview:cView];
    [self presentPopoverFromRect:rect inView:view withContentView:containtView];

}

- (void)presentPopoverFromRect:(CGRect)rect inView:(UIView *)view withContentView:(UIView *)cView {

    UIView *topView = [self getTopViewOfTheWindow];
    CGRect topViewFrame = topView.frame;
    CGRect rectInTopView = [topView convertRect:rect fromView:view];
    
    self.backGroundView.frame = topView.bounds;
    //Get the arrowPoint
    CGPoint arrowPoint = CGPointZero;
    arrowPoint.x = CGRectGetMidX(rectInTopView);
    
    //计算arrowPoint的x坐标防止过于偏左
    float arrowHeight = HNYArrowHeight;
    if (arrowPoint.x < 10 + arrowHeight)
        arrowPoint.x = CGRectGetMaxX(rectInTopView);
    //计算arrowPoint的x坐标防止过于偏右
    else if (topViewFrame.size.width - arrowPoint.x < 10 + arrowHeight)
        arrowPoint.x = CGRectGetMidX(rectInTopView);
    
    //计算arrowPoint的y坐标 具体有popover的方向而定
    arrowPoint.y = CGRectGetMaxY(rectInTopView);
    if (arrowPoint.y > topViewFrame.size.height/2 ){
        self.above = YES;
        arrowPoint.y = CGRectGetMinY(rectInTopView);
    }
    self.arrowPoint = arrowPoint;
    
    CGRect contentRect = CGRectMake((topView.frame.size.width - cView.frame.size.width)/2, 0, cView.frame.size.width, cView.frame.size.height);
    
    //计算显示的content的y坐标
    contentRect.origin.y = arrowPoint.y + HNYArrowHeight;
    if (self.above)
        contentRect.origin.y = arrowPoint.y - contentRect.size.height - HNYArrowHeight;

    cView.frame = contentRect;

    //计算content的中心点 主要是计算content的center的x坐标
    if (self.arrowPoint.x < cView.frame.size.width) {
        cView.center = CGPointMake(cView.frame.size.width /2 + 10, cView.center.y);
    }
    else if ((topView.frame.size.width - self.arrowPoint.x < cView.frame.size.width/2)) {
        cView.center = CGPointMake(topViewFrame.size.width - cView.frame.size.width /2 - 10, cView.center.y);
    }
    else{
        cView.center = CGPointMake(self.arrowPoint.x, cView.center.y);
    }

    self.contentRect = cView.frame;
    cView.layer.cornerRadius = HNYArrowOffset;
    cView.clipsToBounds = YES;
    [self addSubview:cView];
    
}


- (void)presentPopoverAnimated:(BOOL)animated{

    UIView *topView = [self getTopViewOfTheWindow];
    self.layer.anchorPoint = CGPointMake(self.arrowPoint.x / topView.bounds.size.width, self.arrowPoint.y / topView.bounds.size.height);
    self.frame = topView.bounds;
    [topView addSubview:self];
    
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    
    //animate into full size
    //First stage animates to 1.05x normal size, then second stage animates back down to 1x size.
    //This two-stage animation creates a little "pop" on open.
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.f;
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stringAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HNYPopoverViewStringAryCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"ActionSheetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.textLabel.text = [self.stringAry objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(hNYPopoverView:didSelectStringAryAtIndex:)]) {
        [self.delegate hNYPopoverView:self didSelectStringAryAtIndex:indexPath.row];
    }
}

#pragma mark - UITapGestureRecognizer
- (void)tapGestureRecognize:(UITapGestureRecognizer*)gesture{
    [self dismissPopoverAnimated:YES];
}

#pragma mark - dismiss popover
- (void)dismissPopoverAnimated:(BOOL)animated{
    if ([self.delegate respondsToSelector:@selector(hNYPopoverViewWillDismissPopover:)]) {
        [self.delegate hNYPopoverViewWillDismissPopover:self];
    }
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(hNYPopoverViewDidDismissPopover:)]) {
            [self.delegate hNYPopoverViewDidDismissPopover:self];
        }
    }];
}
#pragma mark - Get tht key Window top view
- (UIView*)getTopViewOfTheWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    return [[window subviews] objectAtIndex:0];
}

@end

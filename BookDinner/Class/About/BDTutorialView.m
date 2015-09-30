//
//  BDTutorialView.m
//  BookDinner
//
//  Created by zqchen on 1/9/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDTutorialView.h"
@interface BDTutorialView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) NSArray *stringAry;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic, strong) void (^completion)(BOOL done);

@end

@implementation BDTutorialView

#pragma mark - vies life cycle
- (id)initWith:(NSArray *)imgAry completion:(void (^)(BOOL))completion{
    self = [super init];
    if (self) {
        UIView *topView = [self getTopViewOfTheWindow];
        self.frame = CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height);
        [topView addSubview:self];
        
        if (completion) {
            self.completion = completion;
        }
        [self createScrollView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

- (void)createScrollView{
    int num = 4;
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.backgroundColor = [UIColor whiteColor];
    self.scroll.delegate = self;
    self.scroll.contentSize = CGSizeMake(self.frame.size.width * (num +1), self.frame.size.height);
    self.scroll.contentOffset = CGPointMake(0, 0);
    self.scroll.pagingEnabled = YES;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 70, self.frame.size.width, 20)];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 4;
    self.pageControl.hidden = YES;
    
    for (int i = 0; i < num; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tutorial%d",i+1]]];
        [self.scroll addSubview:imageView];
    }
    [self addSubview:self.scroll];
    [self addSubview:self.pageControl];
    
}
#pragma mark - class method
+ (void)presentTutorialViewWith:(NSArray *)imgAry completion:(void (^)(BOOL))completion{
    BDTutorialView *view = [[BDTutorialView alloc] initWith:imgAry completion:completion];
    NSLog(@"%@",view);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (index == 4) {
        [self performSelector:@selector(dismissPopoverAnimated:) withObject:nil afterDelay:0.0];
    }
    [self.pageControl setCurrentPage:index];
}



- (void)presentPopoverAnimated:(BOOL)animated{
    
//    UIView *topView = [self getTopViewOfTheWindow];
//    self.layer.anchorPoint = CGPointMake(self.arrowPoint.x / topView.bounds.size.width, self.arrowPoint.y / topView.bounds.size.height);
//    self.frame = topView.bounds;
//    [topView addSubview:self];
//    
//    self.alpha = 0.f;
//    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
//    
//    //animate into full size
//    //First stage animates to 1.05x normal size, then second stage animates back down to 1x size.
//    //This two-stage animation creates a little "pop" on open.
//    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.alpha = 1.f;
//        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            self.transform = CGAffineTransformIdentity;
//        } completion:nil];
//    }];
}

#pragma mark - dismiss popover
- (void)dismissPopoverAnimated:(BOOL)animated{
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.completion) {
            self.completion(YES);
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

//
//  HNYScrollView.m
//  HBSmartCity
//
//  Created by chenzq on 6/19/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import "HNYScrollView.h"
@interface HNYScrollView()
@property (nonatomic,strong) NSDate *beganDate;
@end

@implementation HNYScrollView

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

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    if ([view isKindOfClass:[UIButton class]]) {
        self.pagingEnabled = NO;
        return YES;
    }
    return NO;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return NO;
}

@end

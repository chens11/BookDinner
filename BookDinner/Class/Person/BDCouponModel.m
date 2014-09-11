//
//  BDCouponModel.m
//  BookDinner
//
//  Created by zqchen on 15/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDCouponModel.h"

@implementation BDCouponModel
@synthesize state = _state;
@synthesize using = _using;
- (void)setState:(int)state{
    _state = state;
    if (state == 1) {
        self.state_name = @"可使用";
    }
    else if (state == 2) {
        self.state_name = @"已使用";
    }
    else if (state == 13) {
        self.state_name = @"已过期";
    }
}

- (void)setUsing:(int)using{
    _using = using;
    if (using == 1) {
        self.using_name = @"朋友卷";
    }
    else if (using == 0)
        self.using_name = @"";
}
@end

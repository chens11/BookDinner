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
- (void)setState:(NSInteger)state{
    _state = state;
    if (state == 1) {
        self.state_name = @"可使用";
    }
    else if (state == 2) {
        self.state_name = @"已使用";
    }
    else if (state == 3) {
        self.state_name = @"已过期";
    }
}

@end

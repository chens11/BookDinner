//
//  BDOrderModel.m
//  BookDinner
//
//  Created by chenzq on 9/3/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderModel.h"

@implementation BDOrderModel
@synthesize state = _state;
- (void)setState:(int)state{
    _state = state;
    if (_state == 0) {
        self.stateName = @"待付款";
    }
    else if (_state == 1){
        self.stateName = @"已付款";
    }
    else if (_state == 2){
        self.stateName = @"派送中";
    }
    else if (_state == 3){
        self.stateName = @"成交";
    }
    else if (_state == 4){
        self.stateName = @"失效";
    }
}

@end

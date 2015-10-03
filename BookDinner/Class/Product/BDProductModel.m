//
//  BDProductModel.m
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDProductModel.h"

@implementation BDProductModel


- (BDProductModel*)copy{
    BDProductModel *model = [[BDProductModel alloc] init];
    model.ids = self.ids;
    model.title = self.title;
    model.type_id = self.type_id;
    model.number = self.number;
    model.img = self.img;
    model.addtime = self.addtime;
    model.money = self.money;
    model.descriptions = self.descriptions;
    return model;
}
- (BOOL)isEqual:(BDProductModel*)object{
    if ([object isKindOfClass:[BDProductModel class]] && self.ids == object.ids) {
        return true;
    }
    return false;
}
@end

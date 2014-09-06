//
//  BDCouponModel.h
//  BookDinner
//
//  Created by zqchen on 15/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"

@interface BDCouponModel : HNYModel
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic) int debit;
@property (nonatomic) float discount;
@property (nonatomic,strong) NSString *enddate;
@property (nonatomic,strong) NSString *label;
@property (nonatomic) int id;
//状态（1未使用，2已使用，3过期）
@property (nonatomic) int state;
@property (nonatomic,strong) NSString *state_name;
@property (nonatomic) int type;
@property (nonatomic) int using;
@property (nonatomic,strong) NSString *using_name;
@property (nonatomic,strong) NSString *name;

@end

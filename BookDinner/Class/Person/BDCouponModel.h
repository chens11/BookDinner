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
@property (nonatomic) NSInteger debit;
@property (nonatomic) float discount;
@property (nonatomic,strong) NSString *endtime;
@property (nonatomic,strong) NSString *label;
@property (nonatomic) NSInteger ids;
//状态（1未使用，2已使用，3过期 ）
@property (nonatomic) NSInteger state;
@property (nonatomic,strong) NSString *state_name;
//分类（1一元购，2买一送一，3买二送一 4 充值十元 5 充值五元）
@property (nonatomic) NSInteger type;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *money;

@end

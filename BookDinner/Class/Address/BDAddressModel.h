//
//  BDAddressModel.h
//  BookDinner
//
//  Created by zqchen on 14/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"
#import "BDCodeModel.h"

@interface BDAddressModel : HNYModel
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *address;
@property (nonatomic) int id;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) BDCodeModel *prorince;
@property (nonatomic,strong) BDCodeModel *city;
@property (nonatomic,strong) BDCodeModel *district;
@property (nonatomic,strong) BDCodeModel *street;

@end

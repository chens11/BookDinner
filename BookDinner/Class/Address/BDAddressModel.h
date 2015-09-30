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
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic) NSInteger ids;
@property (nonatomic,strong) NSString *is_default;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *area;

@end

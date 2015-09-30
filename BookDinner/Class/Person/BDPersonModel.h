//
//  BDPersonModel.h
//  BookDinner
//
//  Created by zqchen on 31/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"

@interface BDPersonModel : HNYModel
@property (nonatomic,strong) NSString *userimage;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *account;
@property (nonatomic) int score;
@property (nonatomic) int sex;

@end

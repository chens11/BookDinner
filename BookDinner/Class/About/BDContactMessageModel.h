//
//  BDContactMessageModel.h
//  BookDinner
//
//  Created by zqchen on 31/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"

@interface BDContactMessageModel : HNYModel
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic,strong) NSString *admin_reply;
@property (nonatomic) int id;
//0客户 1老板
@property (nonatomic) int type;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *userimg;
@property (nonatomic,strong) NSString *username;

@end

//
//  BDCodeModel.h
//  BookDinner
//
//  Created by zqchen on 28/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"

@interface BDCodeModel : HNYModel

@property (nonatomic) int code;
@property (nonatomic,strong) NSString *name;
//0是表示第一层 无父节点
@property (nonatomic,strong) BDCodeModel *parentCode;
//0省 1市 2地区
@property (nonatomic) int type;

@property (nonatomic) BOOL hasSons;
@property (nonatomic,strong) NSArray *sons;

@end

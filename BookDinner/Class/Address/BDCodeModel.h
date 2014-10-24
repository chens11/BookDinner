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
//0省 1市 2地区 3街道
@property (nonatomic) int type;

@property (nonatomic) BOOL hasSons;
@property (nonatomic,strong) NSArray *sons;

@property (nonatomic) BOOL  expanded; //展开
@property (nonatomic, assign) NSInteger expandLevel; //展开层数
@property (nonatomic) BOOL  selected; //已选

@end

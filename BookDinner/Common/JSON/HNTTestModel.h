//
//  HNTTestModel.h
//  Demo
//
//  Created by chenzq on 5/13/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNTModel.h"

@interface HNTTestModel : HNTModel
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic,strong) NSNumber *number;
@property (nonatomic) int type;


@end

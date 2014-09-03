//
//  HNTTestModel.m
//  Demo
//
//  Created by chenzq on 5/13/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNTTestModel.h"
#import "HNYJSONUitls.h"

@implementation HNTTestModel
@synthesize list = _list;

- (void)setList:(NSArray *)list{
    NSMutableArray *array = [NSMutableArray array];
    for (id object in list) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            [array addObject:[HNYJSONUitls mappingDictionary:object toObjectWithClassName:@"HNTTestModel"]];
        }
    }
    _list = [array copy];
}

@end

//
//  BDAddressModel.m
//  BookDinner
//
//  Created by zqchen on 14/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAddressModel.h"

@implementation BDAddressModel
@synthesize prorince = _prorince;
@synthesize city = _city;
@synthesize district = _district;

- (void)setProrince:(BDCodeModel *)prorince{
    if ([prorince isKindOfClass:[NSDictionary class]]) {
        _prorince  = [HNYJSONUitls mappingDictionary:(NSDictionary*)prorince toObjectWithClassName:@"BDCodeModel"];
    }
    else
        _prorince = prorince;
}

- (void)setCity:(BDCodeModel *)city{
    if ([city isKindOfClass:[NSDictionary class]]) {
        _city  = [HNYJSONUitls mappingDictionary:(NSDictionary*)city toObjectWithClassName:@"BDCodeModel"];
    }
    else
        _city = city;
}

- (void)setDistrict:(BDCodeModel *)district{
    if ([district isKindOfClass:[NSDictionary class]]) {
        _district  = [HNYJSONUitls mappingDictionary:(NSDictionary*)district toObjectWithClassName:@"BDCodeModel"];
    }
    else
        _district = district;
}

@end

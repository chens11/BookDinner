//
//  BDDinnerModel.h
//  BookDinner
//
//  Created by zqchen on 31/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYModel.h"

@interface BDDinnerModel : HNYModel
@property (nonatomic,strong) NSString *description;
@property (nonatomic) int id;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *money;
@property (nonatomic) int number;
@property (nonatomic,strong) NSString *startdate;
@property (nonatomic,strong) NSString *title;


@end

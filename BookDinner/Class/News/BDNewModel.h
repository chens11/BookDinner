//
//  BDNewModel.h
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYModel.h"

@interface BDNewModel : HNYModel
@property (nonatomic) NSInteger ids;
@property (nonatomic) NSInteger type_id;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *addtime;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *descriptions;

@end

//
//  BDHomeViewController.h
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYBaseViewController.h"
#import "BDDinnerModel.h"

@interface BDHomeViewController : HNYBaseViewController
@property (nonatomic,strong) BDDinnerModel *dinnerModel;

- (void)getTodayRecommend;

@end

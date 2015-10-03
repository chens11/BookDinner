//
//  BDProductHeadView.h
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYView.h"
#import "BDProductModel.h"

@interface BDProductHeadView : HNYView
@property (nonatomic,strong) BDProductModel *product;
@property (nonatomic,strong) UILabel *numLabel;

@end

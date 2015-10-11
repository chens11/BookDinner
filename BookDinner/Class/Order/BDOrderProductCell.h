//
//  BDOrderProductCell.h
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYTableViewCell.h"
#import "BDProductModel.h"

@interface BDOrderProductCell : HNYTableViewCell
@property (nonatomic,strong) UIButton *removeBtn;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) BDProductModel *productModel;


@end

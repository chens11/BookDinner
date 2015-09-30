//
//  BDProductCell.h
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYTableViewCell.h"
#import "HNYTextField.h"
#import "BDProductModel.h"

@interface BDProductCell : HNYTableViewCell
@property (nonatomic,strong) UIButton *removeBtn;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) BDProductModel *productModel;

@end

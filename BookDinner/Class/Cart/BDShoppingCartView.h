//
//  BDShoppingCartView.h
//  BookDinner
//
//  Created by zqchen on 9/18/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYView.h"
#import "BDProductModel.h"

@interface BDShoppingCartView : HNYView
@property(nonatomic,strong) NSMutableArray *products;

- (void)addProduct:(BDProductModel *)model;
- (void)removeProduct:(BDProductModel *)model;
- (void)clearProoducts;
- (BDProductModel*)getProductByProductId:(NSInteger )ids;
- (void)updatePrice;

@end

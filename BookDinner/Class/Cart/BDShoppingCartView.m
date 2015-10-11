//
//  BDShoppingCartView.m
//  BookDinner
//
//  Created by zqchen on 9/18/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDShoppingCartView.h"

@interface BDShoppingCartView()
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation BDShoppingCartView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.products = [NSMutableArray array];
        
        self.backgroundColor = [UIColor colorWithRed:61/255.0 green:61/255.0 blue:61/255.0 alpha:1];
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, frame.size.height)];
        self.imgView.contentMode = UIViewContentModeCenter;
        [self.imgView setImage:[UIImage imageNamed:@"shopmenu_shop_card"]];
        [self addSubview:self.imgView];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width - 25, 6, 15, 15)];
        self.numLabel.backgroundColor = [UIColor redColor];
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        self.numLabel.font = [UIFont systemFontOfSize:8];
        self.numLabel.textColor = [UIColor whiteColor];
        self.numLabel.layer.cornerRadius = 8;
        self.numLabel.clipsToBounds = YES;
        [self addSubview:self.numLabel];
        

        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(frame.size.width - 90, 0, 90, frame.size.height);
        [self.button setTitle:@"去下单" forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width, 0, frame.size.width - self.imgView.frame.size.width, frame.size.height)];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.text = @"$ 0.0";
        self.priceLabel.textColor = [UIColor whiteColor];
        self.priceLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.priceLabel];
    }
    return self;
}

- (void)updatePrice{
    

    double sum = 0.0;
    NSInteger num = 0;
    for (BDProductModel *model in self.products) {
        sum += [model.money doubleValue] * (double)model.number;
        num += model.number;
    }
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",sum];
    if (num == 0) {
        self.numLabel.text = @"";
        self.numLabel.hidden = YES;
    }
    else{
        self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
        self.numLabel.hidden = NO;
    }
}

- (void)touchButton:(UIButton*)sender{
    if (self.products.count == 0){
        [self showTips:@"请至少选择一个产品" inView:self.superview];
    }
    else {
        [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]];
    }
}

- (void)addProduct:(BDProductModel *)model{
    BDProductModel *buyModel = [self getProductByProductId:model.ids];
    if (!buyModel) {
        buyModel = [model copy];
        [self.products addObject:buyModel];
    }
    else{
        buyModel.number += 1;
    }
    [self updatePrice];
}

- (void)removeProduct:(BDProductModel *)model{
    BDProductModel *buyModel = [self getProductByProductId:model.ids];
    
    if (buyModel) {
        buyModel.number -= 1;
    }
    [self updatePrice];
}

- (void)clearProoducts{
    [self.products removeAllObjects];
    [self updatePrice];
}

- (BDProductModel *)getProductByProductId:(NSInteger)ids{
    for (BDProductModel *model in self.products) {
        if (ids == model.ids) {
            return model;
        }
    }
    return nil;
}

- (void)setProducts:(NSMutableArray *)products{
    _products = products;
    [self updatePrice];
}
@end

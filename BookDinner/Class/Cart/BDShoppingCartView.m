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
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, frame.size.height)];
        [self addSubview:self.imgView];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width - 40, 20, 20, 20)];
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.text = @"";
        [self addSubview:self.numLabel];
        

        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(frame.size.width - 80, 0, 80, frame.size.height);
        self.button.backgroundColor = [UIColor blueColor];
        [self.button setTitle:@"去结算" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width, 0, frame.size.width - self.imgView.frame.size.width, frame.size.height)];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.text = @"$ 0.0";
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
    self.priceLabel.text = [NSString stringWithFormat:@"$ %f",sum];
    self.numLabel.text = [NSString stringWithFormat:@"%d",num];
}

- (void)touchButton:(UIButton*)sender{
    [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]];
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

- (BDProductModel *)getProductByProductId:(NSInteger)ids{
    for (BDProductModel *model in self.products) {
        if (ids == model.ids) {
            return model;
        }
    }
    return nil;
}
@end

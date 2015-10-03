//
//  BDProductHeadView.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDProductHeadView.h"
@interface BDProductHeadView ()
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *removeBtn;
@property (nonatomic,strong) UIButton *addBtn;


@end

@implementation BDProductHeadView

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.line];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.titleLabel];

        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.priceLabel];

        
        self.removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.removeBtn.tag = 100;
        [self.removeBtn setImage:[UIImage imageNamed:@"LLMenuRemoveRound"] forState:UIControlStateNormal];
        [self.removeBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.removeBtn];
        
        self.numLabel = [[UILabel alloc] init];
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.textColor = [UIColor lightGrayColor];
        self.numLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.numLabel];
        
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.tag = 101;
        [self.addBtn setImage:[UIImage imageNamed:@"LLMenuAddRound"] forState:UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addBtn];
        // Initialization code
    }
    return self;
}

- (void)updateConstraints{
    
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(1/KSCREEN_SCALE);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.left.equalTo(self).offset(8);
    }];
    
    [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
    
    [self.addBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
    }];
    
    [self.numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addBtn.mas_left);
        make.centerY.equalTo(self.addBtn);
        make.bottom.equalTo(self).offset(-8);
        make.width.mas_equalTo(30);
    }];
    
    [self.removeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_left);
        make.centerY.equalTo(self.addBtn);
        make.bottom.equalTo(self).offset(-8);
    }];
    
    [super updateConstraints];
}

- (void)setProduct:(BDProductModel *)product{
    _product = product;
    self.titleLabel.text = _product.title;
    self.priceLabel.text = _product.money;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)product.number];
}

- (void)touchBuyButton:(UIButton*)sender{
    if (sender.tag == 100) {
        [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"remove",@"action", nil]];
    }
    else if (sender.tag == 101) {
        [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"add",@"action", nil]];
    }
    
}

@end

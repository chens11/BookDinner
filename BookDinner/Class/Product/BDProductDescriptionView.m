//
//  BDProductDescriptionView.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDProductDescriptionView.h"

@interface BDProductDescriptionView ()
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;


@end

@implementation BDProductDescriptionView

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.line];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.text = @"产品介绍";
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.detailLabel];
        
        
    }
    return self;
}

- (void)updateConstraints{
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self).offset(8);
    }];
    
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(1/KSCREEN_SCALE);
    }];
    
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(8);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
    }];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailLabel.mas_bottom).offset(8);
    }];
    
    [super updateConstraints];
}

- (void)setProduct:(BDProductModel *)product{
    _product = product;
    self.detailLabel.text = _product.descriptions;
}

@end

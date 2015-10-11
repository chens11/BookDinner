//
//  BDOrderAddressView.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDOrderAddressView.h"

@interface BDOrderAddressView()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end

@implementation BDOrderAddressView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.text = @"请输入地址";
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.nameLabel];
        
        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.text = @"未使用";
        self.phoneLabel.backgroundColor = [UIColor clearColor];
        self.phoneLabel.textAlignment = NSTextAlignmentRight;
        self.phoneLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.phoneLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.numberOfLines = 0;
        self.addressLabel.backgroundColor = [UIColor clearColor];
        self.addressLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.addressLabel];
        
        
    }
    return self;
}
- (void)updateConstraints{
    [super updateConstraints];
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(KFONT_SIZE_MAX_16);
        make.left.equalTo(self).offset(KFONT_SIZE_MAX_16);
    }];
    
    [self.addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(KFONT_SIZE_MAX_16);
        make.left.equalTo(self).offset(KFONT_SIZE_MAX_16);
        make.right.equalTo(self.phoneLabel.mas_left).offset(-KFONT_SIZE_MAX_16);
        make.bottom.equalTo(self).offset(-KFONT_SIZE_MAX_16);
    }];
    
    [self.phoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-KFONT_SIZE_MAX_16);
    }];
}

@end

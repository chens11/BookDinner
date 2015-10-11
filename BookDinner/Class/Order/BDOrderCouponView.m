//
//  BDOrderCouponView.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDOrderCouponView.h"
@interface BDOrderCouponView()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *tailImg;

@end

@implementation BDOrderCouponView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.text = @"优惠券";
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.nameLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.text = @"未使用";
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.textAlignment = NSTextAlignmentRight;
        self.detailLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self addSubview:self.detailLabel];
        
        self.offsetPriceLabel = [[UILabel alloc] init];
        self.offsetPriceLabel.textColor = [UIColor redColor];
        self.offsetPriceLabel.backgroundColor = [UIColor clearColor];
        self.offsetPriceLabel.textAlignment = NSTextAlignmentRight;
        self.offsetPriceLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIN_12];
        [self addSubview:self.offsetPriceLabel];
        
        self.tailImg = [[UIImageView alloc] init];
        self.tailImg.contentMode = UIViewContentModeCenter;
        self.tailImg.image = [UIImage imageNamed:@"nav_back_icon_grey"];
        [self addSubview:self.tailImg];
        

    }
    return self;
}
- (void)updateConstraints{
    [super updateConstraints];
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(KFONT_SIZE_MAX_16);
        make.bottom.equalTo(self).offset(-KFONT_SIZE_MAX_16);
        make.left.equalTo(self).offset(KFONT_SIZE_MAX_16);
    }];
    
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.nameLabel);
        make.right.equalTo(self.tailImg.mas_left).offset(-KFONT_SIZE_MAX_16);
    }];
    
    [self.offsetPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.right.equalTo(self.detailLabel);
    }];
    
    [self.tailImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-KFONT_SIZE_MAX_16);
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.superview endEditing:YES];
    [self.delegate view:self actionWitnInfo:nil];
}

@end

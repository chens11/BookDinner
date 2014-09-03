//
//  BDOrderTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 3/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderTableViewCell.h"

@interface BDOrderTableViewCell()
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *ruleLabel;
@property (nonatomic,strong) UIImageView *tailImg;
@property (nonatomic,strong) UILabel *bgLabel;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UILabel *payLabel;
//@property (nonatomic,strong) UIButton *bgLabel;

@end

@implementation BDOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        
        self.bgLabel = [[UILabel alloc] init];
        self.bgLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgLabel];

        
        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.headImg];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.priceLabel];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        self.statusLabel.textColor = [UIColor whiteColor];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = [UIFont boldSystemFontOfSize:16.0];
//        [self.contentView addSubview:self.statusLabel];
        
        self.ruleLabel = [[UILabel alloc] init];
        self.ruleLabel.textAlignment = NSTextAlignmentRight;
        self.ruleLabel.textColor = [UIColor lightGrayColor];
        self.ruleLabel.backgroundColor = [UIColor clearColor];
        self.ruleLabel.font = [UIFont systemFontOfSize:14.0];
//        [self.contentView addSubview:self.ruleLabel];
        
        self.tailImg = [[UIImageView alloc] init];
        self.tailImg.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:self.tailImg];
        
        self.payLabel = [[UILabel alloc] init];
        self.payLabel.textAlignment = NSTextAlignmentLeft;
        self.payLabel.textColor = [UIColor redColor];
        self.payLabel.backgroundColor = [UIColor clearColor];
        self.payLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.payLabel];

        
        self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payBtn.backgroundColor = ButtonNormalColor;
        self.payBtn.titleLabel.font = ButtonTitleFont;
        [self.payBtn setTitle:@"去支付" forState:UIControlStateNormal];
//        [self.payBtn addTarget:self action:@selector(touchPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.payBtn];
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.headImg setImage:[UIImage imageNamed:@"dinner"]];
    self.nameLabel.text = @"香辣猪扒A套餐";
    self.statusLabel.text = @"交易完成";
    self.ruleLabel.text = @"满100使用";
    self.priceLabel.text = @"￥100";
    self.payLabel.text = @"实际支付: ￥400";
    self.bgLabel.frame = CGRectMake(15 ,10,self.contentView.frame.size.width - 30,self.contentView.frame.size.height-20);

    self.nameLabel.frame = CGRectMake(20 ,15,self.frame.size.width - 150,20);
    self.priceLabel.frame = CGRectMake(self.frame.size.width - 100 ,15,80,20);
    self.headImg.frame = CGRectMake(15 ,35,60,60);
    self.payBtn.frame = CGRectMake(self.frame.size.width - 80, self.frame.size.height - 50, 60, 30);
    self.payLabel.frame = CGRectMake(20, self.frame.size.height - 40, 150, 20);

    self.statusLabel.frame = CGRectMake(self.frame.size.width - 150 ,0,145,20);
    self.ruleLabel.frame = CGRectMake(self.frame.size.width - 100 ,30,80,20);
}
- (void)iniDataWithModel:(id)model{
//    if ([model isKindOfClass:[BDCouponModel class]]) {
//        
//    }
}

@end

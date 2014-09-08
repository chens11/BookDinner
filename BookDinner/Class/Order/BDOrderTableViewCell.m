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
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIImageView *tailImg;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UILabel *payLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *couponLabel;
@property (nonatomic,strong) NSArray *buyTypeAry;

@end

@implementation BDOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        self.buyTypeAry = [NSArray arrayWithObjects:@"本人购买",@"赠送朋友",nil];
        
        self.tailImg = [[UIImageView alloc] init];
        self.tailImg.contentMode = UIViewContentModeScaleToFill;
        self.tailImg.image = [UIImage imageNamed:@"alert_bg1"];
        [self.contentView addSubview:self.tailImg];

        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.headImg setImage:[UIImage imageNamed:@"dinner"]];
        [self.contentView addSubview:self.headImg];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        self.statusLabel.textColor = [UIColor redColor];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:self.statusLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.font = [UIFont systemFontOfSize:14.0];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        self.typeLabel = [[UILabel alloc] init];
        self.typeLabel.textAlignment = NSTextAlignmentLeft;
        self.typeLabel.backgroundColor = [UIColor clearColor];
        self.typeLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.typeLabel];
        
        self.couponLabel = [[UILabel alloc] init];
        self.couponLabel.textAlignment = NSTextAlignmentLeft;
        self.couponLabel.backgroundColor = [UIColor clearColor];
        self.couponLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.couponLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.timeLabel];
        
        self.numLabel = [[UILabel alloc] init];
        self.numLabel.textAlignment = NSTextAlignmentRight;
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.font = [UIFont systemFontOfSize:14.0];
        self.numLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.numLabel];
        
        self.payLabel = [[UILabel alloc] init];
        self.payLabel.textAlignment = NSTextAlignmentLeft;
        self.payLabel.textColor = [UIColor redColor];
        self.payLabel.backgroundColor = [UIColor clearColor];
        self.payLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.payLabel];

        
        self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payBtn.titleLabel.font = ButtonTitleFont;
        [self.payBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [self.payBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
        [self.payBtn addTarget:self action:@selector(touchPayBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    self.tailImg.frame = CGRectMake(10 ,10,self.contentView.frame.size.width - 20,self.contentView.frame.size.height-20);
    self.nameLabel.frame = CGRectMake(20 ,15,self.contentView.frame.size.width - 150,20);
    self.statusLabel.frame = CGRectMake(self.contentView.frame.size.width - 80 ,15,60,20);
    self.priceLabel.frame = CGRectMake(self.contentView.frame.size.width - 150 ,40,130,20);
    self.numLabel.frame = CGRectMake(self.contentView.frame.size.width - 150 ,70,130,20);
    
    self.typeLabel.frame = CGRectMake(110,40,130,20);
    self.couponLabel.frame = CGRectMake(110,65,150,20);
    self.timeLabel.frame = CGRectMake(110, 90, 150, 20);
    
    self.headImg.frame = CGRectMake(20 ,30,80,self.contentView.frame.size.height - 60);
    self.payBtn.frame = CGRectMake(self.contentView.frame.size.width - 80, self.contentView.frame.size.height - 40, 60, 25);
    self.payLabel.frame = CGRectMake(20, self.contentView.frame.size.height - 35, 150, 20);
}
- (void)iniDataWithModel:(BDOrderModel*)model{
    if ([model isKindOfClass:[BDOrderModel class]]) {
        self.nameLabel.text = model.title;
        self.statusLabel.text = model.stateName;
        if (model.img.length > 10) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img]];
            [self.headImg setImageWithURL:url placeholderImage:self.headImg.image options:SDWebImageCacheMemoryOnly];
        }
        self.typeLabel.text = [NSString stringWithFormat:@"购买方式: %@",[self.buyTypeAry objectAtIndex:model.using]];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.1f",[model.pricemoney floatValue]];
        self.numLabel.text = [NSString stringWithFormat:@"x%d",model.order_number];
        self.payLabel.text = [NSString stringWithFormat:@"实际支付￥%.1f",[model.money floatValue]];
        self.timeLabel.text = @"送餐时间: 10:30-11:00";
        self.couponLabel.text = [NSString stringWithFormat:@"优惠券: 未使用"];
        if (model.ticker)
            self.couponLabel.text = [NSString stringWithFormat:@"优惠券: %@(%@)",model.ticker,model.ticker.using_name];
    }
}
#pragma mark - ibaction
- (void)touchPayBtn:(UIButton*)sender{
    
}
@end

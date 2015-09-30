//
//  BDOrderTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 3/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderTableViewCell.h"

@interface BDOrderTableViewCell()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIImageView *tailImg;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UILabel *payLabel;
@property (nonatomic,strong) UILabel *couponLabel;

@end

@implementation BDOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        
        self.tailImg = [[UIImageView alloc] init];
        self.tailImg.contentMode = UIViewContentModeScaleToFill;
        self.tailImg.image = [UIImage imageNamed:@"alert_bg1"];
        [self.contentView addSubview:self.tailImg];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self.contentView addSubview:self.nameLabel];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        self.statusLabel.textColor = [UIColor redColor];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self.contentView addSubview:self.statusLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self.contentView addSubview:self.timeLabel];

        self.couponLabel = [[UILabel alloc] init];
        self.couponLabel.textAlignment = NSTextAlignmentLeft;
        self.couponLabel.backgroundColor = [UIColor clearColor];
        self.couponLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self.contentView addSubview:self.couponLabel];
        
        self.numLabel = [[UILabel alloc] init];
        self.numLabel.textAlignment = NSTextAlignmentRight;
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        self.numLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.numLabel];
        
        self.payLabel = [[UILabel alloc] init];
        self.payLabel.textAlignment = NSTextAlignmentLeft;
        self.payLabel.textColor = [UIColor redColor];
        self.payLabel.backgroundColor = [UIColor clearColor];
        self.payLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self.contentView addSubview:self.payLabel];

        
        self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        self.payBtn.hidden = YES;
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

    self.nameLabel.frame = CGRectMake(15 ,10,self.contentView.frame.size.width - 150,20);
    self.statusLabel.frame = CGRectMake(self.contentView.frame.size.width - 80 ,15,60,20);
    self.timeLabel.frame = CGRectMake(15, 30, self.contentView.frame.size.width - 110, 20);
    self.couponLabel.frame = CGRectMake(110,65,150,20);


    self.numLabel.frame = CGRectMake(15 ,self.contentView.frame.size.height - 35 ,130,20);
    self.payLabel.frame = CGRectMake(145, self.contentView.frame.size.height - 35, self.contentView.frame.size.height - 35 , 20);
    self.payBtn.frame = CGRectMake(self.contentView.frame.size.width - 80, self.contentView.frame.size.height - 40, 60, 25);
}
- (void)configureCellWith:(BDOrderModel*)model{
    if ([model isKindOfClass:[BDOrderModel class]]) {
        self.nameLabel.text = [NSString stringWithFormat:@"订单ID: %@",model.ids];
        self.statusLabel.text = model.stateName;
        if (model.addtime.length > 16) {
            self.timeLabel.text = [NSString stringWithFormat:@"下单时间: %@",[model.addtime substringToIndex:16]];
        }

        self.payLabel.text = [NSString stringWithFormat:@"实际支付￥%.2f",[model.price floatValue]];
        
        float sum = 0.0;
        NSInteger num = 0;
        for (BDProductModel *product in model.product) {
            sum += [product.money doubleValue] * (float)product.number;
            num += product.number;
        }
        self.numLabel.text = [NSString stringWithFormat:@"合计        x%ld",(long)num];
        self.couponLabel.text = [NSString stringWithFormat:@"优惠券: 未使用"];

        if ([model.ticker isKindOfClass:[BDCouponModel class]]){
            model.ticker.using = model.using;
            self.couponLabel.text = [NSString stringWithFormat:@"优惠券: %@",model.ticker.name];
            if (model.ticker.using_name.length > 2)
                self.couponLabel.text = [NSString stringWithFormat:@"优惠券: %@(%@)",model.ticker.name,model.ticker.using_name];
        }
        if (model.state == 0)
            self.payBtn.hidden = NO;
        else
            self.payBtn.hidden = YES;
            
    }
}
#pragma mark - ibaction
- (void)touchPayBtn:(UIButton*)sender{
    [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"touchPayBtn",@"action", nil]];
}
@end

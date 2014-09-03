//
//  BDCouponTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 15/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDCouponTableViewCell.h"
@interface BDCouponTableViewCell()
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *bgLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *valueLabel;
@property (nonatomic,strong) UILabel *ruleLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UIImageView *tailImg;
@property (nonatomic,strong) UIImageView *bgImg;

@end

@implementation BDCouponTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        
        self.bgLabel = [[UILabel alloc] init];
        self.bgLabel.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:self.bgLabel];

        self.bgImg = [[UIImageView alloc] init];
        self.bgImg.contentMode = UIViewContentModeScaleToFill;
        self.bgImg.image = [UIImage imageNamed:@"alert_bg1"];
        [self.contentView addSubview:self.bgImg];
        
        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode = UIViewContentModeScaleToFill;
//        self.headImg.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.headImg];

        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1.0];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.statusLabel];
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.textAlignment = UITextAlignmentRight;
        self.dateLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:self.dateLabel];
        
        self.valueLabel = [[UILabel alloc] init];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.backgroundColor = [UIColor clearColor];
        self.valueLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self.contentView addSubview:self.valueLabel];
        
        self.ruleLabel = [[UILabel alloc] init];
        self.ruleLabel.textAlignment = NSTextAlignmentLeft;
        self.ruleLabel.textColor = [UIColor lightGrayColor];
        self.ruleLabel.backgroundColor = [UIColor clearColor];
        self.ruleLabel.numberOfLines = 0;
        self.ruleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.ruleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:self.ruleLabel];
        
        self.tailImg = [[UIImageView alloc] init];
        self.tailImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.tailImg];
        

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
    self.nameLabel.text = @"订餐优惠券";
    self.dateLabel.text = @"有效期至2014-09-04";
    self.valueLabel.text = @"￥90";
    self.ruleLabel.text = @"本优惠券一次购买满100可以使用";
    self.statusLabel.text = @" 可使用";
    
    self.headImg.frame = CGRectMake(15, 15, 40, self.frame.size.height - 55);
//    self.valueLabel.frame = CGRectMake(0, 0, 80, self.contentView.frame.size.height - 20);
    self.bgLabel.frame = CGRectMake(15 ,10,self.contentView.frame.size.width - 30,self.contentView.frame.size.height-20);
    self.bgImg.frame = CGRectMake(10 ,10,self.contentView.frame.size.width - 20,self.contentView.frame.size.height-20);
    self.nameLabel.frame = CGRectMake(65 ,15,self.frame.size.width - 75,20);
    self.ruleLabel.frame = CGRectMake(65 ,35,self.frame.size.width - 75,self.frame.size.height - 60);

    
    self.statusLabel.frame = CGRectMake(15, self.frame.size.height - 30, self.frame.size.width - 30, 20);
    self.dateLabel.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width-20, 20);

}
- (void)iniDataWithModel:(id)model{
    [self.headImg setImage:[UIImage imageNamed:@"LLScanIndexEvoucher"]];
    if ([model isKindOfClass:[BDCouponModel class]]) {
//        BDCouponModel *cModel = model;
        
    }
}

@end

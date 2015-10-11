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
        
        self.bgImg = [[UIImageView alloc] init];
        self.bgImg.contentMode = UIViewContentModeScaleToFill;
        self.bgImg.image = [UIImage imageNamed:@"alert_bg1"];
        [self.contentView addSubview:self.bgImg];
        
        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.headImg];

        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self.contentView addSubview:self.nameLabel];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1.0];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self.contentView addSubview:self.statusLabel];
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        self.dateLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIN_12];
        [self.contentView addSubview:self.dateLabel];
        
        self.valueLabel = [[UILabel alloc] init];
        self.valueLabel.textAlignment = NSTextAlignmentCenter;
        self.valueLabel.backgroundColor = [UIColor clearColor];
        self.valueLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self.contentView addSubview:self.valueLabel];
        
        self.ruleLabel = [[UILabel alloc] init];
        self.ruleLabel.textAlignment = NSTextAlignmentLeft;
        self.ruleLabel.textColor = [UIColor lightGrayColor];
        self.ruleLabel.backgroundColor = [UIColor clearColor];
        self.ruleLabel.numberOfLines = 0;
        self.ruleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.ruleLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIN_12];
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
    self.headImg.frame = CGRectMake(15, 15, 40, self.contentView.frame.size.height - 55);
    self.bgImg.frame = CGRectMake(10 ,10,self.contentView.frame.size.width - 20,self.contentView.frame.size.height-20);
    self.nameLabel.frame = CGRectMake(65 ,15,self.contentView.frame.size.width - 75,20);
    self.ruleLabel.frame = CGRectMake(65,30,self.contentView.frame.size.width - 80,self.contentView.frame.size.height - 60);
    
    self.statusLabel.frame = CGRectMake(15, self.contentView.frame.size.height - 35, self.contentView.frame.size.width - 30, 20);
    self.dateLabel.frame = CGRectMake(0, self.contentView.frame.size.height - 35, self.contentView.frame.size.width-20, 20);

}
- (void)configureCellWith:(BDCouponModel*)model{
    [self.headImg setImage:[UIImage imageNamed:@"LLScanIndexEvoucher"]];
    if ([model isKindOfClass:[BDCouponModel class]]) {
        self.nameLabel.text = model.name;
        self.statusLabel.text = model.state_name;
        self.ruleLabel.text = model.label;
        self.dateLabel.text = [NSString stringWithFormat:@"有效期至 %@",model.endtime];        
    }
}

@end

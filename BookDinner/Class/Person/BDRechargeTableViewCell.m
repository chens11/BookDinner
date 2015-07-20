//
//  BDRechargeTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 26/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDRechargeTableViewCell.h"
@interface BDRechargeTableViewCell()
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UIImageView *tailImg;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UILabel *payLabel;

@end

@implementation BDRechargeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        
        self.tailImg = [[UIImageView alloc] init];
        self.tailImg.contentMode = UIViewContentModeScaleToFill;
        self.tailImg.image = [UIImage imageNamed:@"alert_bg1"];
        [self.contentView addSubview:self.tailImg];
        
        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.headImg setImage:[UIImage imageNamed:@"dinner"]];
//        [self.contentView addSubview:self.headImg];
        
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
    
    self.timeLabel.frame = CGRectMake(18, 40, self.contentView.frame.size.width - 110, 20);
    
    self.headImg.frame = CGRectMake(20 ,30,80,self.contentView.frame.size.height - 60);
    self.payBtn.frame = CGRectMake(self.contentView.frame.size.width - 80, self.contentView.frame.size.height - 40, 60, 25);
    self.payLabel.frame = CGRectMake(20, self.contentView.frame.size.height - 35, 150, 20);
}
- (void)configureCellWith:(BDOrderModel*)model{
    if ([model isKindOfClass:[BDOrderModel class]]) {
        self.nameLabel.text = [NSString stringWithFormat:@"充值: ￥%@",model.money];
        self.statusLabel.text = model.stateName;
        if (model.img.length > 10) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.img]];
            [self.headImg setImageWithURL:url placeholderImage:self.headImg.image options:SDWebImageCacheMemoryOnly];
        }
        self.payLabel.text = [NSString stringWithFormat:@"实际支付￥%.2f",[model.money floatValue]];
        if (model.addtime.length > 16) {
            self.timeLabel.text = [NSString stringWithFormat:@"下单时间:%@",[model.addtime substringToIndex:16]];
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

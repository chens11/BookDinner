//
//  BDOrderTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 3/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderTableViewCell.h"
#import "BDProductModel.h"

@interface BDOrderTableViewCell()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIImageView *tailImg;
@property (nonatomic,strong) UIButton *payBtn;
@property (nonatomic,strong) UILabel *payLabel;
@property (nonatomic,strong) UILabel *couponLabel;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) BDOrderModel *order;

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
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self.contentView addSubview:self.timeLabel];
        
        
        self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.table.dataSource = self;
        self.table.userInteractionEnabled = NO;
        self.table.delegate = self;
        self.table.separatorColor = [UIColor clearColor];
        [self.contentView addSubview:self.table];
        
        self.couponLabel = [[UILabel alloc] init];
        self.couponLabel.textAlignment = NSTextAlignmentLeft;
        self.couponLabel.backgroundColor = [UIColor clearColor];
        self.couponLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self.contentView addSubview:self.couponLabel];
        


        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        self.statusLabel.textColor = [UIColor redColor];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self.contentView addSubview:self.statusLabel];
        

        self.numLabel = [[UILabel alloc] init];
        self.numLabel.textAlignment = NSTextAlignmentRight;
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        self.numLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.numLabel];
        
        self.payLabel = [[UILabel alloc] init];
        self.payLabel.textAlignment = NSTextAlignmentRight;
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
    [self updateConstraints];
}

- (void)updateConstraints{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [self.tailImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.right.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(14);
        make.right.equalTo(self.timeLabel.mas_left);
    }];
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(14);
        make.right.equalTo(self.contentView).offset(-14);
    }];
    

    [self.table mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(40*self.order.product.count);
    }];
    
    [self.couponLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(24);
        make.right.equalTo(self.contentView).offset(-14);
        make.top.equalTo(self.table.mas_bottom).offset(10);
    }];
    

    [self.payLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_left).offset(10);
        make.right.equalTo(self.contentView).offset(-14);
        make.top.equalTo(self.couponLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.contentView).offset(-18);
    }];
    
    
    [self.numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right).offset(30);
        make.top.equalTo(self.couponLabel.mas_bottom).offset(10);
    }];
    
    
    [self.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(14);
        make.top.equalTo(self.couponLabel.mas_bottom).offset(10);
    }];

    [super updateConstraints];
}
- (void)configureCellWith:(BDOrderModel*)model{
    if ([model isKindOfClass:[BDOrderModel class]]) {
        self.order = model;
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

        if (self.order.ticker_id == 0) {
            self.couponLabel.text = [NSString stringWithFormat:@"优惠券:      未使用"];
        }
        else{
            self.couponLabel.text = [NSString stringWithFormat:@"优惠券:  %@ -¥ %.2f",self
                                     .order.ticker_name,[self.order.ticker_money doubleValue]];
        }
        if (model.state == 0)
            self.payBtn.hidden = NO;
        else
            self.payBtn.hidden = YES;
        [self.table reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.order.product.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BDProductModel *model = [self.order.product objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIN_12];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"x %ld   ¥ %.2f",(long)model.number,[model.money doubleValue] * model.number];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

+ (NSInteger)cellHeightWith:(id)model maxWidth:(CGFloat)maxWidth{
    BDOrderTableViewCell *cell = [[BDOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BDOrderTableViewCell"];
    [cell configureCellWith:model];
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    [cell.contentView layoutIfNeeded];
    return  cell.contentView.frame.size.height;
}
#pragma mark - ibaction
- (void)touchPayBtn:(UIButton*)sender{
    [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"touchPayBtn",@"action", nil]];
}
@end

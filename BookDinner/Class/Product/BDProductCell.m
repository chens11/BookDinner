//
//  BDProductCell.m
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDProductCell.h"

@interface BDProductCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *headImg;

@end


@implementation BDProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode  = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.headImg];
        
        self.removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.removeBtn.tag = 100;
        [self.removeBtn setImage:[UIImage imageNamed:@"LLMenuRemoveRound"] forState:UIControlStateNormal];
        [self.removeBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.removeBtn];
        
        self.numLabel = [[UILabel alloc] init];
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        self.numLabel.backgroundColor = [UIColor clearColor];
        self.numLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.numLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.priceLabel];
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.tag = 101;
        [self.addBtn setImage:[UIImage imageNamed:@"LLMenuAddRound"] forState:UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addBtn];
                // Initialization code
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.headImg.frame = CGRectMake(8, 8, self.frame.size.height - 8, self.frame.size.height - 8);
    self.textLabel.frame = CGRectMake(self.frame.size.height + 10, 10, self.frame.size.width - self.frame.size.height, 40);
    self.priceLabel.frame = CGRectMake(self.frame.size.height + 10, self.frame.size.height - 40, 80, 30);
    self.addBtn.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height - 30, 20, 20);
    self.numLabel.frame = CGRectMake(self.frame.size.width - 70, self.frame.size.height - 30, 30, 20);
    self.removeBtn.frame = CGRectMake(self.frame.size.width - 90, self.frame.size.height - 30, 20, 20);
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
}

- (void)configureCellWith:(BDProductModel*)model{
    if ([model isKindOfClass:[BDProductModel class]]) {
        self.productModel = model;
        self.textLabel.text = model.title;
        self.priceLabel.text = model.money;
        [self.headImg setImageWithURL:[NSURL URLWithString:model.img]];
    }
}
- (void)touchBuyButton:(UIButton*)sender{
  if (sender.tag == 100) {
      [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"remove",@"action", nil]];
    }
    else if (sender.tag == 101) {
        [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"add",@"action", nil]];
    }

}

@end

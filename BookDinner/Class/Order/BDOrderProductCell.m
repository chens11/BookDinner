//
//  BDOrderProductCell.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDOrderProductCell.h"

@interface BDOrderProductCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;

@end


@implementation BDOrderProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.removeBtn.tag = 100;
        self.removeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
        self.removeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
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
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.priceLabel];
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBtn.tag = 101;
        self.addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
        self.addBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.addBtn setImage:[UIImage imageNamed:@"LLMenuAddRound"] forState:UIControlStateNormal];
        [self.addBtn addTarget:self action:@selector(touchBuyButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addBtn];
        // Initialization code
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 120, self.frame.size.height);
    
    self.priceLabel.frame = CGRectMake(self.frame.size.width - 150, 0, 50, self.frame.size.height);
    
    self.addBtn.frame = CGRectMake(self.frame.size.width - 40, 0 , 30, self.frame.size.height);
    self.numLabel.frame = CGRectMake(self.frame.size.width - 60, 0, 20, self.frame.size.height);
    self.removeBtn.frame = CGRectMake(self.frame.size.width - 90, 0, 30, self.frame.size.height);
    
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
}

- (void)configureCellWith:(BDProductModel*)model{
    if ([model isKindOfClass:[BDProductModel class]]) {
        self.productModel = model;
        self.textLabel.text = model.title;
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.money doubleValue] * model.number];
        self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)model.number];
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

- (void)setEditAble:(BOOL)editAble{
    _editAble = editAble;
    self.addBtn.enabled = editAble;
    self.removeBtn.enabled = editAble;
}

@end

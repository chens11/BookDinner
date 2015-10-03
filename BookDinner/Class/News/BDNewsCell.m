//
//  BDNewsCell.m
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDNewsCell.h"
#import "BDNewModel.h"

@interface BDNewsCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *headImg;

@end


@implementation BDNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode  = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.headImg];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];

        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.detailLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLabel];
                // Initialization code
    }
    return self;
}
- (void)updateConstraints{
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.headImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.centerY.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(8);
        make.width.mas_equalTo(100);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(8);
        make.top.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);

    }];
    
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(8);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-8);
        make.right.equalTo(self.contentView).offset(-8);
        
    }];
    
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.right.equalTo(self.contentView).offset(-8);
        
    }];

    [super updateConstraints];
}

- (void)configureCellWith:(BDNewModel*)model{
    if ([model isKindOfClass:[BDNewModel class]]) {
        [self.headImg setImageWithURL:[NSURL URLWithString:model.img]];
        self.titleLabel.text = model.title;
        self.detailLabel.text = model.descriptions;
        self.timeLabel.text = model.addtime;
        
        
        [self setNeedsUpdateConstraints];
        [self needsUpdateConstraints];
        [self.contentView setNeedsUpdateConstraints];
        [self.contentView needsUpdateConstraints];

    }
}

@end

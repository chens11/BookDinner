//
//  BDAddressSelectorTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 28/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAddressSelectorTableViewCell.h"

@interface BDAddressSelectorTableViewCell()
@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) BDCodeModel *codeModel;

@end

@implementation BDAddressSelectorTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:237.0/255 green:234.0/255 blue:225.0/255 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:16.0];
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:self.nameLabel];
        
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
    if (self.codeModel.type == 0 || self.codeModel.type == 3) {
        self.nameLabel.frame = CGRectMake(5, 0, self.frame.size.width - 5, self.frame.size.height);
    }
    else if (self.codeModel.type == 1) {
        self.nameLabel.frame = CGRectMake(25, 0, self.frame.size.width - 25, self.frame.size.height);
    }
    else if (self.codeModel.type == 2) {
        self.nameLabel.frame = CGRectMake(45, 0, self.frame.size.width - 45, self.frame.size.height);
    }
}
- (void)iniDataWithModel:(BDCodeModel*)model{
    if ([model isKindOfClass:[BDCodeModel class]]) {
        self.codeModel = model;
        self.nameLabel.text = model.name;
    }
}

@end

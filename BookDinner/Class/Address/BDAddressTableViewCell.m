//
//  BDAddressTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 14/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDAddressTableViewCell.h"
@interface BDAddressTableViewCell()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end

@implementation BDAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.nameLabel];

        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.backgroundColor = [UIColor clearColor];
        self.phoneLabel.textAlignment = NSTextAlignmentRight;
        self.phoneLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.phoneLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.numberOfLines = 0;
        self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.addressLabel.backgroundColor = [UIColor clearColor];
        self.addressLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        self.addressLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.addressLabel];

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
    self.phoneLabel.frame = CGRectMake(self.frame.size.width - 145,10, 115, 30);
    self.nameLabel.frame = CGRectMake(10, 10, self.frame.size.width - 155, 30);
    self.addressLabel.frame = CGRectMake(10, 40, self.frame.size.width - 40, self.frame.size.height - 40);
    if (self.tag == 0) {
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    }
}
- (void)iniDataWithModel:(id)model{
    if ([model isKindOfClass:[BDAddressModel class]]) {
        BDAddressModel *cModel = model;
        self.nameLabel.text = cModel.name;
        self.phoneLabel.text = cModel.tel;
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",cModel.prorince.name,cModel.city.name,cModel.district.name,cModel.street.name,cModel.address];
    }
}

@end


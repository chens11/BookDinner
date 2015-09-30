//
//  BDPersonTableViewCell.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDPersonTableViewCell.h"

@interface BDPersonTableViewCell()
@property (nonatomic,strong) UILabel *headLabel;
@property (nonatomic,strong) UILabel *tailLabel;
@property (nonatomic,strong) UIImageView *tailView;

@end


@implementation BDPersonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.headLabel = [[UILabel alloc] init];
        self.headLabel.backgroundColor = [UIColor clearColor];
        self.headLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.headLabel];
        
        self.tailLabel = [[UILabel alloc] init];
        self.tailLabel.backgroundColor = [UIColor clearColor];
        self.tailLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.tailLabel];
        
        self.tailView = [[UIImageView alloc] init];
        self.tailView.contentMode = UIViewContentModeScaleAspectFit;
        [self.tailView setImage:[UIImage imageNamed:@"iconRightArrow"]];
        [self addSubview:self.tailView];
        // Initialization code
        
        self.bottomLine.backgroundColor = [UIColor lightGrayColor];
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
    self.tailView.frame = CGRectMake(self.frame.size.width - 20, (self.frame.size.height - 20)/2, 20, 20);
    self.headLabel.frame = CGRectMake(5, 0, self.frame.size.width - 25, self.frame.size.height);
    self.tailLabel.frame = CGRectMake(5, 0, self.frame.size.width - 25, self.frame.size.height);
}
- (void)configureCellWith:(id)model{
    if ([model isKindOfClass:[BDMenuModel class]]) {
        BDMenuModel *cModel = model;
        self.headLabel.text = cModel.title;
        
//        if ([@"recommended" isEqualToString:cModel.type]) {
//            [self.headView setImage:[UIImage imageNamed:@"menu_icon_logo"]];
//        }
//        else if([@"center" isEqualToString:cModel.type]) {
//            [self.headView setImage:[UIImage imageNamed:@"menu_icon_account"]];
//        }
//        else if([@"setting" isEqualToString:cModel.type]) {
//            [self.headView setImage:[UIImage imageNamed:@"menu_icon_setting"]];
//        }
//        else if([@"about" isEqualToString:cModel.type]) {
//            [self.headView setImage:[UIImage imageNamed:@"menu_icon_information"]];
//        }
//        self.label.text = cModel.title;
    }
    
}

@end

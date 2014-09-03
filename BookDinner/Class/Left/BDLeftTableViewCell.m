//
//  BDLeftTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 13/7/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDLeftTableViewCell.h"
@interface BDLeftTableViewCell()
@property (nonatomic,strong) UIImageView *headView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *tailView;

@end


@implementation BDLeftTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headView = [[UIImageView alloc] init];
        self.headView.contentMode = UIViewContentModeCenter;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.headView];
        
        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont boldSystemFontOfSize:15.0];
        [self addSubview:self.label];
        
        self.tailView = [[UIImageView alloc] init];
        self.tailView.contentMode = UIViewContentModeScaleAspectFit;
        [self.tailView setImage:[UIImage imageNamed:@"iconRightArrow"]];
//        [self addSubview:self.tailView];
        // Initialization code
        
        self.bottomLine.backgroundColor = [UIColor colorWithRed:75/255.0 green:63/255.0 blue:58/255.0 alpha:1.0];
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
    self.headView.frame = CGRectMake(15, (self.frame.size.height - 25)/2, 25, 25);
    self.tailView.frame = CGRectMake(self.frame.size.width - 20, (self.frame.size.height - 20)/2, 20, 20);
    self.label.frame = CGRectMake(50, 0, self.frame.size.width - 60 - 20, self.frame.size.height);
}
- (void)iniDataWithModel:(id)model{
    if ([model isKindOfClass:[BDMenuModel class]]) {
        BDMenuModel *cModel = model;
        
        if ([@"recommended" isEqualToString:cModel.type]) {
            [self.headView setImage:[UIImage imageNamed:@"menu_icon_logo"]];
        }
        else if([@"center" isEqualToString:cModel.type]) {
            [self.headView setImage:[UIImage imageNamed:@"menu_icon_account"]];
        }
        else if([@"setting" isEqualToString:cModel.type]) {
            [self.headView setImage:[UIImage imageNamed:@"menu_icon_setting"]];
        }
        else if([@"about" isEqualToString:cModel.type]) {
            [self.headView setImage:[UIImage imageNamed:@"menu_icon_information"]];
        }
        if (self.tag == 0) {
            self.topLine.backgroundColor = [UIColor colorWithRed:75/255.0 green:63/255.0 blue:58/255.0 alpha:1.0];
        }
        self.label.text = cModel.title;
    }

}
@end

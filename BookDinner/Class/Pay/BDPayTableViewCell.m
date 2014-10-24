//
//  BDPayTableViewCell.m
//  BookDinner
//
//  Created by chenzq on 9/5/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDPayTableViewCell.h"

@interface BDPayTableViewCell()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *headImg;

@end


@implementation BDPayTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.textColor = [UIColor lightGrayColor];
        self.contentLabel.font = [UIFont boldSystemFontOfSize:13.0];
        [self addSubview:self.contentLabel];
        
        self.headImg = [[UIImageView alloc] init];
        self.headImg.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.headImg];
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
    if (self.contentLabel.text) {
        self.headImg.frame = CGRectMake(5, 0, 30, self.frame.size.height);
        self.titleLabel.frame = CGRectMake(40, 0, self.frame.size.width - 45, self.frame.size.height - 20);
        self.contentLabel.frame = CGRectMake(40, self.frame.size.height - 20, self.frame.size.width - 45, 15);
    }
    else{
        self.titleLabel.frame = CGRectMake(5, 0, self.frame.size.width - 5, self.frame.size.height);
    }
}
- (void)iniDataWithModel:(NSDictionary*)model{
    if ([model isKindOfClass:[NSDictionary class]]){
        self.titleLabel.text = [model valueForKey:@"title"];
        self.contentLabel.text = [model valueForKey:@"content"];
        if (self.contentLabel.text == nil)
            self.titleLabel.textColor = [UIColor redColor];
        else
            self.titleLabel.textColor = [UIColor blackColor];
        if (self.tag == 0) {
            [self.headImg setImage:[UIImage imageNamed:@"weichat_logo"]];
        }
        if (self.tag == 1) {
            [self.headImg setImage:[UIImage imageNamed:@"alipay_logo"]];
        }
        if (self.tag == 2) {
            [self.headImg setImage:[UIImage imageNamed:@"my_wallet"]];
        }
    }
    
}

@end

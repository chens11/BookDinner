//
//  BDContactBossTableViewCell.m
//  BookDinner
//
//  Created by zqchen on 21/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDContactBossTableViewCell.h"

@interface BDContactBossTableViewCell()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *tailLabel;
@property (nonatomic) float labelWidth;
@property (nonatomic,strong) UIImageView *bubbleImgView;
@property (nonatomic,strong) BDContactMessageModel *model;

@end


@implementation BDContactBossTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        
        self.bubbleImgView = [[UIImageView alloc] init];
        self.bubbleImgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.bubbleImgView];

        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.numberOfLines = 0;
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.label];
        
        self.tailLabel = [[UILabel alloc] init];
        self.tailLabel.backgroundColor = [UIColor clearColor];
        self.tailLabel.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.tailLabel];
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
    CGSize size = [self.label.text sizeWithFont:[UIFont systemFontOfSize:KFONT_SIZE_MAX_16] constrainedToSize:CGSizeMake(self.frame.size.width - 65, 999) lineBreakMode:NSLineBreakByWordWrapping];


    if (self.model.type == 1) {
        self.label.frame = CGRectMake(15, 15, size.width, self.frame.size.height - 30);
        self.bubbleImgView.frame = CGRectMake(0, 5, size.width + 25, self.frame.size.height - 10);
    }
    else{
        self.label.frame = CGRectMake(self.frame.size.width - size.width - 15, 15, size.width, self.frame.size.height - 30);
        self.bubbleImgView.frame = CGRectMake(self.frame.size.width - size.width - 25, 5, size.width + 25, self.frame.size.height - 10);
    }
//    self.headLabel.frame = CGRectMake(5, 0, self.frame.size.width - 25, self.frame.size.height);
//    self.tailLabel.frame = CGRectMake(5, 0, self.frame.size.width - 25, self.frame.size.height);
}
- (void)configureCellWith:(BDContactMessageModel*)model{

    if ([model isKindOfClass:[BDContactMessageModel class]]) {
        self.model = model;
        if (model.type == 1)
        {
            self.label.text = model.admin_reply;
            self.label.textAlignment = NSTextAlignmentLeft;
            self.bubbleImgView.image = [[UIImage imageNamed:@"bubbleBoss"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        }
        else{
            self.label.text = model.message;
            self.label.textAlignment = NSTextAlignmentRight;
            self.bubbleImgView.image = [[UIImage imageNamed:@"bubbleMine"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
        }

    }


}


@end

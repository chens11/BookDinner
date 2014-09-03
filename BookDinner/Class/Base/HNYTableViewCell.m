//
//  HNYTableViewCell.m
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTableViewCell.h"

@implementation HNYTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bottomLine = [[UILabel alloc] init];
        self.bottomLine.backgroundColor = [UIColor clearColor];
        self.bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.bottomLine];
        
        self.topLine = [[UILabel alloc] init];
        self.topLine.backgroundColor = [UIColor clearColor];
        self.topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.topLine];

        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bottomLine.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
    self.topLine.frame = CGRectMake(0, 0, self.frame.size.width, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)iniDataWithModel:(id)model{
    
}
@end

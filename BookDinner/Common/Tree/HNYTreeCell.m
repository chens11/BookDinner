//
//  HNYTreeCell.m
//  HBSmartCity
//
//  Created by chenzq on 6/10/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import "HNYTreeCell.h"

@implementation HNYTreeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
- (void)configureCellWith:(id)model{
    if ([model isKindOfClass:[HNYTreeModel class]]) {
        HNYTreeModel *treeModel = model;
        self.textLabel.text = [treeModel title];
    }
}
@end

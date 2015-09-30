//
//  BDNewsCell.m
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDNewsCell.h"
#import "BDNewModel.h"

@implementation BDNewsCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
}

- (void)configureCellWith:(BDNewModel*)model{
    if ([model isKindOfClass:[BDNewModel class]]) {
        self.textLabel.text = model.title;
    }
}

@end

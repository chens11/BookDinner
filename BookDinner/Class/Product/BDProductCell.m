//
//  BDProductCell.m
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDProductCell.h"
#import "BDProductModel.h"

@implementation BDProductCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)configureCellWith:(BDProductModel*)model{
    if ([model isKindOfClass:[BDProductModel class]]) {
        self.textLabel.text = model.title;
    }
}
@end

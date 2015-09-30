//
//  HNYTreeCell.h
//  HBSmartCity
//
//  Created by chenzq on 6/10/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNYTreeModel.h"

@interface HNYTreeCell : UITableViewCell
@property (nonatomic) int expandLevel;
@property (nonatomic) BOOL expanded;
- (void)configureCellWith:(id)model;

@end

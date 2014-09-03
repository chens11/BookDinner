//
//  HNYTableViewCell.h
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
#import "UIImageView+WebCache.h"

@interface HNYTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *bottomLine;
@property (nonatomic,strong) UILabel *topLine;

- (void)iniDataWithModel:(id)model;

@end

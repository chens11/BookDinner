//
//  HNYNaviBar.h
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNYNaviBarItem.h"

@interface HNYNaviBar : UIView
@property (nonatomic,strong) NSArray *leftItems;
@property (nonatomic,strong) NSArray *rightItems;
@property (nonatomic,strong) NSString *title;

@end

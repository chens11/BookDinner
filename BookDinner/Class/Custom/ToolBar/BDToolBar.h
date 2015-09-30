//
//  BDToolBar.h
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYView.h"
#import "BDToolBarItem.h"

@interface BDToolBar : HNYView
@property (nonatomic,strong) NSMutableArray *subMenuAry;
@property (nonatomic) NSInteger selectIndex;
@property (nonatomic) NSInteger defaultSelectedIndex;


@end

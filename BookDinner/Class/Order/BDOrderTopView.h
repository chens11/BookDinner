//
//  BDOrderTopView.h
//  BookDinner
//
//  Created by chenzq on 9/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYView.h"
#import "BDOrderTopItemView.h"
@interface BDOrderTopView : HNYView
@property (nonatomic,strong) NSMutableArray *subMenuAry;
@property (nonatomic) NSInteger selectIndex;
@property (nonatomic) NSInteger defaultSelectedIndex;

@end

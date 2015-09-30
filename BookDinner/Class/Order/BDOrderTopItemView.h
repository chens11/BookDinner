//
//  BDOrderTopItemView.h
//  BookDinner
//
//  Created by chenzq on 9/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYView.h"
#import "BDMenuModel.h"

@interface BDOrderTopItemView : HNYView
@property (nonatomic,strong) BDMenuModel *menuModel;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic) NSInteger exTag;
@property (nonatomic) BOOL selected;

- (void)touchButton:(UIButton*)sender;

@end

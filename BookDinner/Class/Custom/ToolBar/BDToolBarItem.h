//
//  BDToolBarItem.h
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "HNYView.h"
#import "BDMenuModel.h"

@interface BDToolBarItem : HNYView
@property (nonatomic,strong) BDMenuModel *menuModel;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic) NSInteger exTag;
@property (nonatomic) BOOL selected;

- (void)touchButton:(UIButton*)sender;

@end

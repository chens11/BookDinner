//
//  BDToolBarItem.m
//  BookDinner
//
//  Created by zqchen on 7/25/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDToolBarItem.h"

@interface BDToolBarItem()<HNYDelegate>
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *rightLine;

@end


@implementation BDToolBarItem
@synthesize menuModel = _menuModel;
@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.contentMode = UIViewContentModeScaleToFill;
        //        [self addSubview:self.bgImageView];
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont boldSystemFontOfSize:KFONT_SIZE_MIDDLE_14];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        self.rightLine = [[UILabel alloc] init];
        self.rightLine.backgroundColor = [UIColor clearColor];
        [self addSubview:self.rightLine];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.frame;
    self.bgImageView.frame = CGRectMake(0, frame.size.height*1/3, frame.size.width, frame.size.height*2/3);
    self.button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.rightLine.frame = CGRectMake(0, self.frame.size.height - 2, self.frame.size.width, 2);
    //    if (self.exTag > 0)
    //        self.rightLine.frame = CGRectMake(0, 10, 2, 24);
    //
}


- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (selected){
        self.bgImageView.image = [UIImage imageNamed:@"iconSubMenuSelected"];
        self.label.textColor = [UIColor redColor];
        self.rightLine.backgroundColor = [UIColor redColor];
    }
    else{
        self.bgImageView.image = nil;
        self.label.textColor = [UIColor blackColor];
        self.rightLine.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - IBAction
- (void)touchButton:(UIButton*)sender{
    self.selected = YES;
    [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.menuModel,@"subMenuSelected", nil]];
}
- (void)setMenuModel:(BDMenuModel *)menuModel{
    _menuModel =  menuModel;
    self.label.text = menuModel.title;
}

#pragma mark - HBPublicDelegate
- (void)view:(UIView *)aView actionWitnInfo:(NSDictionary *)info{
    [self.delegate view:self actionWitnInfo:info];
}

#pragma mark - HNYPopoverViewDelegate
@end

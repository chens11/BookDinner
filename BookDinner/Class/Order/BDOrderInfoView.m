//
//  BDOrderInfoView.m
//  BookDinner
//
//  Created by zqchen on 10/3/15.
//  Copyright (c) 2015 chenzq. All rights reserved.
//

#import "BDOrderInfoView.h"
@interface BDOrderInfoView()
@property (nonatomic,strong) UILabel *numLeftLabel;
@property (nonatomic,strong) UILabel *numRightLabel;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *priceLeftLabel;
@property (nonatomic,strong) UILabel *priceRightLabel;

@end

@implementation BDOrderInfoView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.numLeftLabel = [[UILabel alloc] init];
        self.numLeftLabel.text = @"总数";
        self.numLeftLabel.backgroundColor = [UIColor clearColor];
        self.numLeftLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.numLeftLabel];
        
        self.numRightLabel = [[UILabel alloc] init];
        self.numRightLabel.backgroundColor = [UIColor clearColor];
        self.numRightLabel.textAlignment = NSTextAlignmentRight;
        self.numRightLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self addSubview:self.numRightLabel];
        
        self.priceLeftLabel = [[UILabel alloc] init];
        self.priceLeftLabel.text = @"总价";
        self.priceLeftLabel.backgroundColor = [UIColor clearColor];
        self.priceLeftLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MAX_16];
        [self addSubview:self.priceLeftLabel];
        
        self.priceRightLabel = [[UILabel alloc] init];
        self.priceRightLabel.backgroundColor = [UIColor clearColor];
        self.priceRightLabel.textAlignment = NSTextAlignmentRight;
        self.priceRightLabel.font = [UIFont systemFontOfSize:KFONT_SIZE_MIDDLE_14];
        [self addSubview:self.priceRightLabel];
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.line];
        

        
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    [self.numLeftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(KFONT_SIZE_MAX_16);
        make.bottom.equalTo(self.line.mas_top).offset(-8);
        make.right.equalTo(self.numRightLabel.mas_left);
        make.left.equalTo(self).offset(KFONT_SIZE_MAX_16);
    }];
    
    [self.numRightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(KFONT_SIZE_MAX_16);
        make.bottom.equalTo(self.line.mas_top).offset(-8);
        make.right.equalTo(self).offset(-KFONT_SIZE_MAX_16);
    }];
    
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(KFONT_SIZE_MAX_16);
        make.right.equalTo(self);
        make.height.mas_equalTo(1/KSCREEN_SCALE);
    }];
    
    [self.priceLeftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(8);
        make.bottom.equalTo(self).offset(-KFONT_SIZE_MAX_16);
        make.right.equalTo(self.priceRightLabel.mas_left);
        make.left.equalTo(self).offset(KFONT_SIZE_MAX_16);
    }];
    
    [self.priceRightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(8);
        make.bottom.equalTo(self).offset(-KFONT_SIZE_MAX_16);
        make.right.equalTo(self).offset(-KFONT_SIZE_MAX_16);
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.superview endEditing:YES];
}

- (void)updateNum:(NSInteger)num price:(double)price{
    self.numRightLabel.text = [NSString stringWithFormat:@"x    %ld",(long)num];
    self.priceRightLabel.text = [NSString stringWithFormat:@"¥    %.2f",price];
}
@end

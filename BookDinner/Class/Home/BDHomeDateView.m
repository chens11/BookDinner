//
//  BDHomeDateView.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDHomeDateView.h"
@interface BDHomeDateView()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UILabel *monthLabel;
@property (nonatomic,strong) UILabel *dateLabel;

@end

@implementation BDHomeDateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *monthAry = [NSArray arrayWithObjects:@"一月",@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月", nil];
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.bgImageView.image = [UIImage imageNamed:@"bg_date"];
        [self addSubview:self.bgImageView];

        self.monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, frame.size.width,frame.size.height/3)];
        self.monthLabel.text = [monthAry objectAtIndex:[HNYTools getMonthNumByDate:[NSDate date]]];
        self.monthLabel.textAlignment = NSTextAlignmentCenter;
        self.monthLabel.textColor = [UIColor blackColor];
        self.monthLabel.font = [UIFont systemFontOfSize:14];
        self.monthLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.monthLabel];

        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/3, frame.size.width,frame.size.height*2/3)];
        self.dateLabel.text = [NSString stringWithFormat:@"%d",[HNYTools getDateNumByDate:[NSDate date]]];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.textColor = [UIColor blackColor];
        self.dateLabel.font = [UIFont boldSystemFontOfSize:24];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.dateLabel];

        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  BDContactBossInputView.m
//  BookDinner
//
//  Created by zqchen on 21/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDContactBossInputView.h"
@interface BDContactBossInputView()
@end

@implementation BDContactBossInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.msgTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 75, 35)];
        self.msgTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.msgTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.msgTextView.layer.borderWidth = 1.0;
        self.msgTextView.layer.cornerRadius = 3;
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        button.frame = CGRectMake(self.frame.size.width - 55, 11, 45, 33);
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toucheSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self addSubview:self.msgTextView];

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
#pragma mark - IBAction

- (void)toucheSendButton:(UIButton*)sender{
    [self endEditing:YES];
    if (self.msgTextView.text.length == 0) {
        return;
    }
    [self.delegate view:self actionWitnInfo:[NSDictionary dictionaryWithObjectsAndKeys:self.msgTextView.text,@"message", nil]];
    self.msgTextView.text = @"";
}
@end

//
//  HNYTextField.m
//  BookDinner
//
//  Created by chenzq on 8/29/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTextField.h"

@implementation HNYTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect textRect = [super textRectForBounds:bounds];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7) {
         textRect.origin.y = (self.frame.size.height - self.font.lineHeight)/2;
    }
    return textRect;
}


- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect textRect = [super textRectForBounds:bounds];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7) {
        textRect.origin.y = (self.frame.size.height - self.font.lineHeight)/2;
    }
    return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect textRect = [super textRectForBounds:bounds];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7) {
        textRect.origin.y = (self.frame.size.height - self.font.lineHeight)/2;
    }
    return textRect;
}
@end

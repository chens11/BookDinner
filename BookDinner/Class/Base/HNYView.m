//
//  HNYView.m
//  BookDinner
//
//  Created by chenzq on 7/14/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYView.h"

@implementation HNYView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KCOLOR_VIEW_BACKGROUND;
        // Initialization code
    }
    return self;
}

- (void)showTips:(NSString *)tips inView:(UIView*)aView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = tips;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
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

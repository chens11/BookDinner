//
//  BDTutorialView.h
//  BookDinner
//
//  Created by zqchen on 1/9/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNYView.h"

@interface BDTutorialView : HNYView
+ (void)presentTutorialViewWith:(NSArray *)imgAry completion:(void(^) (BOOL done))completion;

@end

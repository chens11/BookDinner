//
//  HNYDownTableView.h
//  VillageEducation
//
//  Created by chenzq on 4/24/14.
//  Copyright (c) 2014 hubei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNYDownTableView;

@protocol HNYDownTableViewDelegate <NSObject>

- (void)hnyDownTableView:(HNYDownTableView*)view didSelectIndex:(NSInteger)index;

@end

@interface HNYDownTableView : UIView
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) id nameKey;
@property (nonatomic,strong) id idKey;
@property (nonatomic,strong) NSNumber *defaultSelectIndex;
@property (nonatomic,strong) NSNumber *multiPliChoice;
@property (nonatomic,  weak) id <HNYDownTableViewDelegate> delegate;

- (void)dismissDownTableWithAnimated:(BOOL)animated;
@end

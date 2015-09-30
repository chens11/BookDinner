//
//  HNYTableView.h
//  VillageEducation
//
//  Created by chenzq on 4/24/14.
//  Copyright (c) 2014 hubei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNYTableView;
@protocol HNYTableViewDelegate <NSObject>

- (void)hnyTableView:(HNYTableView*)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HNYTableView : UITableView
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) id nameKey;
@property (nonatomic,strong) id idKey;
@property (nonatomic,  weak) id <HNYTableViewDelegate> cutDelegate;
@property (nonatomic,strong) NSNumber *defaultSelectIndex;

@end

//
//  HNYTreeView.h
//  HBSmartCity
//
//  Created by chenzq on 6/10/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNYTreeModel.h"
#import "HNYTreeCell.h"

@class HNYTreeView;

@protocol HNYTreeViewDelegate <NSObject>
@required

@optional
- (void)treeView:(HNYTreeView*)treeView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)treeView:(HNYTreeView*)treeView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (HNYTreeCell *)treeView:(HNYTreeView*)treeView cellForRowAtIndexPath:(NSIndexPath *)indexPath withReuseIdentifier:(NSString*)identifier;

@end

@interface HNYTreeView : UIView
@property (nonatomic,strong) NSArray *originalList;
@property (nonatomic,strong) NSString *treeCellClassName;
@property (nonatomic,weak) id <HNYTreeViewDelegate> delegate;
@property (nonatomic) BOOL singleChoice;
@property (nonatomic) BOOL showCheckMark;


- (HNYTreeModel*)getOriginalModelWithIndexPath:(NSIndexPath*)indexPath;
- (void)reloadData;

@end

//
//  HNYTreeModel.h
//  HBSmartCity
//
//  Created by chenzq on 6/10/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBModel.h"

//@class HNYTreeModel;
//@protocol HNYTreeModelDelegate <NSObject>
//@required
//@property (nonatomic,weak) id <HNYTreeModelDelegate> delegate;
//
//@end

@interface HNYTreeModel : HBModel
- (NSString*)uniqueId;
- (NSString*)title;
- (BOOL)hasSons;
- (NSArray*)sons;

@end

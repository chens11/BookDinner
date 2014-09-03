//
//  HNYDelegate.h
//  BookDinner
//
//  Created by chenzq on 7/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HNYDelegate <NSObject>
@optional

- (void)viewController:(UIViewController*)vController actionWitnInfo:(NSDictionary*)info;
- (void)view:(UIView*)aView actionWitnInfo:(NSDictionary*)info;


@end

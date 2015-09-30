//
//  AppInfo.h
//  BookDinner
//
//  Created by zqchen on 25/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

+ (NSDictionary*)headInfo;
+ (BOOL)isValidateMobile:(NSString *)mobile;

@end

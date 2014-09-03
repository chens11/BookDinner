//
//  HNYTools.m
//  BookDinner
//
//  Created by chenzq on 8/29/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYTools.h"

@implementation HNYTools

+ (int)getMonthNumByDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:date];
    return [components month];
}

+ (int)getDateNumByDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [components day];
}

@end

//
//  AppInfo.m
//  BookDinner
//
//  Created by zqchen on 25/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

+ (NSDictionary *)headInfo{
//    timestamp：时间戳
//    version：版本号
//    device_type：设备类型
//    screen_size：设备的屏幕大小
//    token：未登录值为空
//    account：游客发送默认账号defaultAccount：其他发送真是账号
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *version = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
    NSDate *date = [NSDate date];
    long long timeStamp = [date timeIntervalSince1970];
    
    NSString *account = [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
    if (!account) {
        account = @"defaultAccount";
    }

    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    if (!token) {
        token = @"";
    }

    CGSize size = [UIApplication sharedApplication].keyWindow.bounds.size;
    NSString *sizeStr = [NSString stringWithFormat:@"%.0f*%.0f",size.width,size.height];
    
    [dictionary setValue:@"IOS" forKey:@"device_type"];
    [dictionary setValue:sizeStr forKey:@"screen_size"];
    [dictionary setValue:token forKey:@"token"];
    [dictionary setValue:account forKey:@"account"];
    [dictionary setValue:[NSNumber numberWithLongLong:timeStamp] forKey:@"timestamp"];
    [dictionary setValue:version forKey:@"version"];
    return dictionary;
}
+ (BOOL)isValidateMobile:(NSString *)mobile {
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1[0-9]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


@end

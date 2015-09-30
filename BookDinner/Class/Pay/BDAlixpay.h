//
//  BDAlixpay.h
//  BookDinner
//
//  Created by zqchen on 24/10/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "BDOrderModel.h"


//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088611220647166"
//收款支付宝账号
#define SellerID  @"m13430089368@163.com"

#define NotifyURL @"http%3a%2f%2fgangrong.yaxinw.com%2falipayapp%2fnotify_url.php"


//xiaochang2014
//xiaochang20140904


//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"c9az8cbwx5713jzikppf3lkb1jwhiggf"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALBlukNKekXc0e8SG/UxB8PcRacKiTgnB1y+x7rHijXSuB/tQgJfDoOoxY77BMHziUrsC2SdzWcfIPdFcxBNLUYv/ia/MRuMd655ojH9iiH6tK4NYzSatVzJchr63tYTFAbvnRjsf5UXLABQARbzXkrCrNPvG7uaIgWuy3EhoCUBAgMBAAECgYAvuLW1cra1o9HfvaR2pvcU08i8MiuBV320Z6CdNVJ80S8i5AsRnSnOEKCx19MnrX0dGdLTO6XQGinO+6jvZhGzEe9KeM8xkj5lEzf6faMTv5qdrdz/xA7OcY03CmfozZWtNEoR9VMqwbwPSGgV80shjfZplVo4jmYHI+K4ZQdkqQJBAOdcr+eMj7MEXcYJcy3piaYte6aTb1Gub/qoZOj2Od5FyzB7R3bGBUXraE41dWotqfoYcAQXVkWLhjkU5u6sCNMCQQDDLpyzD0W+IfoTBZ4+HooGo9MvaiB3Kkr49ESsTbF3reEK43fGVbsQIs5n26clqX9bOHq8GAiunq1KMk4jIbZbAkAc0xJjUcLRddjNBH5iGPd6Sa5fGX1D+uyemP5Be/PHuoBPIPzNUmxzwplzLPvc56WGsCa8i7/G2FQ3pmADGlHbAkAZVSFtdBv/M3W7pk0Fjv0nI3gzfTi9frXAXiPToTnZaK3+tctD6LigvYPAoxesobUv58K2SwBFeb7QFHtjv+plAkEAt+9h11BemYhE+Rye9ayQnIAPr5aULwIE90BOt6zvXQUWl8VLTZvs6q3yQ9dnlEP8lTOS4E3SyRFsrXrknoJyaw=="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"


@interface BDAlixpay : NSObject

+ (NSString*)getOrderInfo:(BDOrderModel*)model;
+ (NSString*)doRsa:(NSString*)orderInfo;

@end

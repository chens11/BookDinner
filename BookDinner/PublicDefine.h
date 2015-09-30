//
//  PublicDefine.h
//  HBSmartCity
//
//  Created by chenzq on 6/4/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 接入第三方应用的key
#define KAPP_UMSocialApp                                    @"54450fd3fd98c5d71500f17d"
#define KAPP_WeiXinApp                                      @"wxaf8a85474669b5f7"
#define KAPP_TencentApp                                     @"c7394704798a158208a74ab60104f0ba"
#define KAPP_YiXinApp                                       @"yx35664bdff4db42c2b7be1e29390c1a06"
#define KAPP_BaiDuMapApp                                    @"ypiiC3pQzaDVHG8ajmLzniMn"

#pragma mark - 用户信息的key
#define KUSER_ACCOUNT                                       @"account"
#define KUSER_PASSWORD                                      @"password"
#define KUSER_NEW_PASSWORD                                  @"new_password"
#define KUSER_CONFIRM_PASSWORD                              @"confirm_password"
#define KUSER_NAME                                          @"username"
#define KUSER_PHONE_NUM                                     @"phone_num"
#define KUSER_SEX                                           @"sex"
#define KUSER_IMG                                           @"userimage"
#define KUSER_IMG_TYPE                                      @"userimagetype"
#define KUSER_ADDRESS                                       @"address"
#define KUSER_ADDRESS_CODE                                  @"address_code"
#define KUSER_ADDRESS_STREET                                @"street"
#define KUSER_IS_LOGIN                                      @"user_is_login"

#pragma mark - Notification的key
#define KNotification_Action_Login                          @"NotificationActionLogin"
#define KNotification_Action_Logout                         @"NotificationActionLogout"
#define KNotification_App_Did_Become_Active                 @"NotificationAppDidBecomeActive"
#define KNotification_Pay_Sucess                            @"NotificationPaySucess"

#pragma mark - UI字体大小
#define KFONT_SIZE_MAX_16                                   16
#define KFONT_SIZE_MIDDLE_14                                14
#define KFONT_SIZE_MIN_12                                   12

#pragma mark - UI颜色
#define KCOLOR_VIEW_BACKGROUND                              [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1.0]
#define KCOLOR_BUTTON_NORMAL                                [UIColor colorWithRed:236.0/255 green:95.0/255 blue:52.0/255 alpha:1.0]
#define KSCREEN_SCALE                                       [UIScreen mainScreen].scale

#pragma mark - 记录app必要信息的key
#define KAPPINFO_HadShowTutorial                             @"HadShowTutorial"
#define KAPPINFO_RememberPassWord                            @"RememberPassWord"
#define KAPPINFO_AutoLogin                                   @"AutoLogin"
#define KAPPINFO_APP_TYPE                                    @"IOS"

#pragma mark - 数据请求和返回的key
#define HTTP_HEAD                                           @"head"
#define HTTP_RESULT                                         @"status"
#define HTTP_INFO                                           @"info"
#define HTTP_VALUE                                          @"value"
#define HTTP_DATA                                          @"data"
#define HTTP_USER_INFO                                      @"user_info"
#define HTTP_TOKEN                                          @"token"

#pragma mark - 接口
#define KAPI_ServerUrl                                   @"http://gangrong.yaxinw.com/"
#define KAPI_ActionTest                                  @"?m=Test&a=post"
#define KAPI_ActionReister                               @"?c=User&a=reg"
#define KAPI_ActionLogin                                 @"?c=User&a=login"
#define KAPI_ActionGetConfirmCode                        @"?c=server&a=captcha"
#define KAPI_ActionChangePassWord                        @"?c=User&a=password"
#define KAPI_ActionResetPassWord                         @"?c=User&a=getPassword"
#define KAPI_ActionGetPersonInfo                         @"?c=User&a=getUserInfo"
#define KAPI_ActionSavePersonInfo                        @"?c=User&a=editUserInfo"
#define KAPI_ActionSavePersonImg                         @"API/?c=user&a=editimg"
#define KAPI_ActionGetAddressList                        @"?c=Address&a=getAddressList"
#define KAPI_ActionGetAddressProvince                    @"?c=server&a=getProvince"
#define KAPI_ActionGetAddressCity                        @"?c=Server&a=getCity"
#define KAPI_ActionGetAddressBlock                       @"?c=Server&a=getDistrict"
#define KAPI_ActionGetAddressStreet                      @"API/?c=server&a=getstreet"
#define KAPI_ActionAddAddress                            @"?c=Address&a=addAddress"
#define KAPI_ActionSaveAddress                           @"?c=Address&a=editAddress"
#define KAPI_ActionDeleteAddress                         @"?c=Address&a=deleteAddress"

#define KAPI_ActionProductsCategory                         @"?c=Product&a=getProductType"
#define KAPI_ActionProductsList                             @"?c=Product&a=getProductList"
#define KAPI_ActionProductDetail                            @"?c=Product&a=getProductId"

#define KAPI_ActionNewsCategory                             @"?c=News&a=getNewsType"
#define KAPI_ActionNewsList                                 @"?c=News&a=getNewsList"
#define KAPI_ActionNewDetail                                @"?c=News&a=getNewsId"


#define KAPI_ActionSing                                  @"API/?c=user&a=sign"
#define KAPI_ActionGetDeclaration                        @"API/?c=info&a=getdeclaration"
#define KAPI_ActionGetBossInfo                           @"?c=Server&a=configs"
#define KAPI_ActionGetMessage                            @"API/?c=info&a=getmessage"
#define KAPI_ActionAddMessage                            @"API/?c=info&a=addmessage"
#define KAPI_ActionCheckVersion                          @"API/?c=product&a=todayrecommended"
#define KAPI_ActionPayOrder                              @"?c=Order&a=addOrder"
#define KAPI_ActionGetOrderList                          @"?c=Order&a=getOrderList"
#define KAPI_ActionLuckyDraw                             @"API/?c=ticker&a=dazhuanpan"
#define KAPI_ActionLuckyDrawList                         @"?c=User&a=getUserTicker"
#define KAPI_ActionGetOrderDetail                        @"?c=Order&a=getOrderId"
#define KAPI_ActionGetRechargeRecordList                 @"?c=Recharge&a=getRechargeList"
#define KAPI_ActionRecharge                              @"?c=Recharge&a=addRecharge"
#define KAPI_ActionRechargeRecordById                    @"API/?c=user&a=getmoneyid"
#define KAPI_ActionPayByWallet                           @"API/?c=product&a=alipaygoods"


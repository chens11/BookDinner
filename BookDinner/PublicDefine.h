//
//  PublicDefine.h
//  HBSmartCity
//
//  Created by chenzq on 6/4/14.
//  Copyright (c) 2014 cndatacom. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KAPP_UMSocialApp                                    @"54450fd3fd98c5d71500f17d"
#define KAPP_WeiXinApp                                      @"wxaf8a85474669b5f7"
#define KAPP_TencentApp                                     @"c7394704798a158208a74ab60104f0ba"
#define KAPP_YiXinApp                                       @"yx35664bdff4db42c2b7be1e29390c1a06"
#define KAPP_BaiDuMapApp                                    @"ypiiC3pQzaDVHG8ajmLzniMn"


#define HTTP_HEAD                                           @"head"
#define HTTP_RESULT                                         @"status"
#define HTTP_INFO                                           @"info"
#define HTTP_VALUE                                          @"value"
#define HTTP_USER_INFO                                      @"user_info"
#define HTTP_TOKEN                                          @"token"


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


#define KNotification_Action_Login                          @"NotificationActionLogin"
#define KNotification_Action_Logout                         @"NotificationActionLogout"
#define KNotification_App_Did_Become_Active                 @"NotificationAppDidBecomeActive"
#define KNotification_Pay_Sucess                            @"NotificationPaySucess"


#define KFONT_SIZE_MAX_16                                   16
#define KFONT_SIZE_MIDDLE_14                                14
#define KFONT_SIZE_MIN_12                                   12


#define KCOLOR_VIEW_BACKGROUND                              [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1.0]
#define KCOLOR_BUTTON_NORMAL                                [UIColor colorWithRed:236.0/255 green:95.0/255 blue:52.0/255 alpha:1.0]
#define KSCREEN_SCALE                                       [UIScreen mainScreen].scale


#define HadShowTutorial                             @"HadShowTutorial"
#define RememberPassWord                            @"RememberPassWord"
#define AutoLogin                                   @"AutoLogin"
#define APP_TYPE                                    @"IOS"

#define ServerUrl                                   @"http://gangrong.yaxinw.com/"
#define ActionTest                                  @"API/1.php"
#define ActionReister                               @"?c=User&a=reg"
#define ActionLogin                                 @"?c=User&a=login"
#define ActionGetConfirmCode                        @"?c=server&a=captcha"
#define ActionChangePassWord                        @"?c=User&a=password"
#define ActionResetPassWord                         @"API/?c=user&a=getpassword"
#define ActionGetPersonInfo                         @"?c=User&a=getUserInfo"
#define ActionSavePersonInfo                        @"?c=User&a=editUserInfo"
#define ActionSavePersonImg                         @"API/?c=user&a=editimg"
#define ActionGetAddressList                        @"?c=Address&a=getAddressList"
#define ActionGetAddressProvince                    @"API/?c=server&a=getprovince"
#define ActionGetAddressCity                        @"API/?c=server&a=getcity"
#define ActionGetAddressBlock                       @"API/?c=server&a=getdistrict"
#define ActionGetAddressStreet                      @"API/?c=server&a=getstreet"
#define ActionAddAddress                            @"API/?c=user&a=addaddress"
#define ActionSaveAddress                           @"API/?c=user&a=editaddressid"
#define ActionDeleteAddress                         @"API/?c=user&a=deleteaddressid"
#define ActionGetTodayRecommend                     @"API/?c=product&a=todayrecommended"
#define ActionSing                                  @"API/?c=user&a=sign"
#define ActionGetDeclaration                        @"API/?c=info&a=getdeclaration"
#define ActionGetBossInfo                           @"?c=Server&a=configs"
#define ActionGetMessage                            @"API/?c=info&a=getmessage"
#define ActionAddMessage                            @"API/?c=info&a=addmessage"
#define ActionCheckVersion                          @"API/?c=product&a=todayrecommended"
#define ActionPayOrder                              @"API/?c=product&a=addorder"
#define ActionGetOrderList                          @"API/?c=product&a=getorder"
#define ActionLuckyDraw                             @"API/?c=ticker&a=dazhuanpan"
#define ActionLuckyDrawList                         @"API/?c=ticker&a=getticker"
#define ActionGetOrderDetail                        @"API/?c=product&a=getorderid"
#define ActionGetRechargeRecordList                 @"API/?c=user&a=getmoney"
#define ActionRecharge                              @"API/?c=user&a=money"
#define ActionRechargeRecordById                    @"API/?c=user&a=getmoneyid"
#define ActionPayByWallet                           @"API/?c=product&a=alipaygoods"


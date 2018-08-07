//D
//  Header_AppConfig.h
//  AnXin
//
//  Created by xxb on 2018/1/26.
//  Copyright © 2018年 xxb. All rights reserved.
//

#ifndef Header_AppConfig_h
#define Header_AppConfig_h


//上线需修改，1正式服
#ifdef DEBUG
#define V_AppStore (1)
#else
#define V_AppStore (1)
#endif




#if (V_AppStore == 1) //正式
#define apiHost @"https://api.anxinyc.com"
#define apiHost_packageDeatil @"https://mobile.anxinyc.com"
#define XBText_UMChannel @"App Store"
#define XBText_UMAliasType @"userId"
#else                //测试
#define apiHost @"https://tapi.anxinyc.com"
#define apiHost_packageDeatil @"https://tmobile.anxinyc.com"
#define XBText_UMChannel @"Develop"
#define XBText_UMAliasType @"userId"
#endif


//QQ登录/分享APPKEY
#define XBText_QQ_APPKEY @"1106746802"
//友盟APPKEY
#define XBText_USHARE_DEMO_APPKEY @"5a93b86df29d980fb1000137"

//微信appid
#define XBText_weChatAppId @"wx634128d6db8c15cd"
#define XBText_weChatAppSecret @"75bf85878994d867fd4bcec28ccca5aa"



//小程序分享的path
#define XBText_path_inviteUseApp            @"/pages/index/index?type=1&userId=%@"
#define XBText_path_inviteJoinGroup         @"/pages/index/index?type=2&id=%@"
#define XBText_path_shareAAOrder            @"/pages/order/index/index?type=pay&ids=%@"



//高德地图ApiKEY
#define XBText_AMapServices_APiKEY @"5a4a20cb54f222550e3780ec6a56cdf7"


/*****************************一些设置*******************************/

#define birthdayDateFormat @"yyyy年MM月dd日"
#define dateFormat_YYYY_MM_dd_Space_HH_mm_ss @"YYYY-MM-dd HH:mm:ss"
#define dateFormat_YYYY_MM_dd_Space_HH_mm @"YYYY-MM-dd HH:mm"
#define dateFormat_HH_mm @"HH:mm"
#define dateFormat_HH @"HH"
#define dateFormat_YYYY_MM_dd @"YYYY-MM-dd"


#define getMineBGIMG \
({\
    UIImage *image = nil;\
    if (isIphone5Screen)\
    {\
        image = XBImage_top背景四寸;\
    }\
    else if (isIphone6Screen)\
    {\
        image = XBImage_top背景四点七寸;\
    }\
    else if (isIphone6PScreen)\
    {\
        image = XBImage_top背景五点五寸;\
    }\
    else\
    {\
        image = XBImage_top背景五点八寸;\
    }\
    image;\
})
//设置navigationBar背景
#define setNavigationBarBackgroundImg \
({\
[self.navigationController.navigationBar setBackgroundImage:getMineBGIMG forBarMetrics:UIBarMetricsDefault];\
});



//获取tabbar阴影图片
#define getTabbarShadowImg \
({\
UIImage *img_tabbarShadow = nil;\
if (isIphone5Screen)\
{\
    img_tabbarShadow = XBImage_tabbar阴影四寸;\
}\
else if (isIphone6Screen)\
{\
    img_tabbarShadow = XBImage_tabbar阴影四点七寸;\
}\
else if (isIphone6PScreen)\
{\
    img_tabbarShadow = XBImage_tabbar阴影五点五寸;\
}\
else if (isIphoneXScreen)\
{\
    img_tabbarShadow = XBImage_tabbar阴影五点八寸;\
}\
img_tabbarShadow;\
})
//设置tabbar阴影
#define setTabbarShadowImg \
({\
    [[UITabBar appearance] setShadowImage:getTabbarShadowImg];\
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];\
});
#endif /* Header_AppConfig_h */

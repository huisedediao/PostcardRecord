//
//  Header_Number.h
//  AnXin
//
//  Created by xxb on 2018/1/18.
//  Copyright © 2018年 xxb. All rights reserved.
//

#ifndef Header_Number_h
#define Header_Number_h

///服务器返回数据异常的错误码
#define kResponseErrorCode (1008611)

///团餐预定页面，周几和日期view的宽度
#define kBespeakVCWeakDateViewWidth (GWidthFactorFun(56))

//内容距离左边的宽度
#define kLeftSpaceToScreen (GWidthFactorFun(13.5))

//添加地址页面tableViewCell的高度
#define kAddAddressTableViewCellHeight (GHeightFactorFun(58))

//饭团页面tableViewCell的高度
#define kDefaultTableViewCellHeight (GHeightFactorFun(44))

//选择餐具弹出菜单tableViewCell的高度
#define kTablewareChooseViewRowHeight (GHeightFactorFun(40))

//团餐预定BespeakTableViewCell的高度
//#define kBespeakTableViewCellHeight (GHeightFactorFun(95))
#define kBespeakTableViewCellHeight ((kScreenWidth - kBespeakVCWeakDateViewWidth - (3 * GWidthFactorFun(5))) * 0.5 + GWidthFactorFun(10))

//一个dishInfoView的高度
#define kDishInfoViewCellHeight GHeightFactorFun(70)

//去结算工具栏的高度
#define kToPayToolBarHeight (49)

//康复食疗套餐cell的高度
#define kRecuperateContentTableViewCellHeight (GWidthFactorFun(80))
#define kRecuperateContentTableViewCellHeight_showUseSingleLabel (GWidthFactorFun(60))


//购物车信息的cell的高度
#define kShoppingCarInfoTableViewCellHeight (GHeightFactorFun(70))

//首页titleView的宽度
#define kMainVCTitleViewWidth (kScreenWidth - 160)


//选择饭团弹窗的宽度
#define kChooseGroupAlertViewWidth (280)

////已有地址中离当前定位最近，并且与当前定位地址距离小于kMaxDistanceForNearestAddress米才算匹配到最近地址，大于kMaxDistanceForNearestAddress显示定位地址
#define kMaxDistanceForNearestAddress (1000)

///首页套餐的整体高度
#define k_mainVCCellHeight GHeightFactorFun(140)
///首页套餐名字的高度
#define k_mainVCCellPackageNameHeight GHeightFactorFun(30)

///每页返回的套餐数
#define k_packageCountPerPage (10)

#define k_noResultSpaceToBottom ((kScreenHeight - SafeAreaTopHeight - 64 - SafeAreaBottomHeight - 100) * 0.5)


#define k_tipHiddenTime (1)

#endif /* Header_Number_h */

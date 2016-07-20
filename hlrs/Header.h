//
//  Header.h
//  hlrs
//
//  Created by qimingyuan on 15/1/3.
//  Copyright (c) 2015年 qimingyuan. All rights reserved.
//

#ifndef hlrs_Header_h
#define hlrs_Header_h

//判断当前系统是否为ios7
#define ISIOS7 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0 ? YES : NO)

//self.view原点偏移量
#define ORGIN_Y_OFFSET (ISIOS7 > 0 ? (20+44) : 0)

//设备屏幕大小
#define __MainScreenFrame   [[UIScreen mainScreen] bounds]
//设备屏幕宽
#define __MainScreen_Width  __MainScreenFrame.size.width
//设备屏幕高 20,表示状态栏高度.如3.5inch 的高,得到的__MainScreenFrame.size.height是480,而去掉电量那条状态栏,我们真正用到的是460;
#define __MainScreen_Height (__MainScreenFrame.size.height-20)

#ifdef __IPHONE_7_0
#define IOS7SYS
#endif

#define IOSVERSION [[[UIDevice currentDevice]systemVersion]floatValue]
#define IPHONESTR (__MainScreen_Width > 500 ? @"iphone5" : @"iphone4")
#define AGENTVALUE [NSString stringWithFormat:@"ios_%f_%@",IOSVERSION,IPHONESTR]

#define OFFSET_Y 0

//4s   960*640
//5s   1136*640
//6    1334*750
//6plus 1920*1080
/*
#define MAINURL @"http://www.zjhnrs.gov.cn:9080/peopleclub/ViewNoticeServlet?url=/zwxx/zwxx_ggxx.htm&name=%B9%AB%B8%E6%CD%A8%D6%AA"*/

#define UPDATEURL @"http://www.hnlss.gov.cn:9080/peopleclub/page/SysLoadForIos.jsp"

#define APPVERSION @"1.0"
#define VERSIONCODE 1

#endif

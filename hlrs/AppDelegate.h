//
//  AppDelegate.h
//  hlrs
//
//  Created by qimingyuan on 14/12/23.
//  Copyright (c) 2014年 qimingyuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIScrollView *m_scrollerview;
    UIPageControl *pageControl;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIScrollView *m_scrollerview;
@property (strong, nonatomic) UIPageControl *pageControl;

@end


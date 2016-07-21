//
//  AppDelegate.m
//  hlrs
//
//  Created by qimingyuan on 14/12/23.
//  Copyright (c) 2014年 qimingyuan. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "Constant.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,__MainScreen_Height-60,__MainScreen_Width-40,20)];
        //        pageControl.strokeNormalColor = [UIColor whiteColor];
        //        pageControl.strokeSelectedColor = [UIColor yellowColor];
        pageControl.numberOfPages = 3;
        pageControl.currentPage = 0;
//        [pageControl setPageIndicatorTintColor:[UIColor blackColor]];
        
        m_scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, OFFSET_Y+20, __MainScreen_Width, __MainScreen_Height)];
        m_scrollerview.delegate = self;
        m_scrollerview.contentSize = CGSizeMake(__MainScreen_Width *3, __MainScreen_Height);
        m_scrollerview.showsHorizontalScrollIndicator = NO;
        m_scrollerview.showsVerticalScrollIndicator = NO;
        m_scrollerview.alwaysBounceVertical = NO;
        m_scrollerview.alwaysBounceHorizontal = YES;
        m_scrollerview.bounces = YES;
        m_scrollerview.pagingEnabled = TRUE;
        
        NSString *imgName1;
        NSString *imgName2;
        NSString *imgName3;
        
        NSLog(@"MAIN SCREEN HEIGHT = %f, MAIN SCREEN WIDTH = %f", __MainScreen_Height, __MainScreen_Width);
        if(__MainScreen_Height == 460)
        {
            NSLog(@"IPHONE 4S");
            imgName1 = @"4_1.png";
            imgName2 = @"4_2.png";
            imgName3 = @"4_3.png";
            
        }
        else if (__MainScreen_Height == 548)
        {
            NSLog(@"IPHONE 5S");
            imgName1 = @"5_1.png";
            imgName2 = @"5_2.png";
            imgName3 = @"5_3.png";
            
        }
        else if (__MainScreen_Height == 548 && __MainScreen_Width == 320)
        {
            NSLog(@"IPHONE 6");
            imgName1 = @"6_1.png";
            imgName2 = @"6_2.png";
            imgName3 = @"6_3.png";
            
        }
        else if (__MainScreen_Height == 716)
        {
            NSLog(@"IPHONE 6PLUS");
            imgName1 = @"6p_1.png";
            imgName2 = @"6p_2.png";
            imgName3 = @"6p_3.png";
            
        }
        else
        {
            imgName1 = @"5_1.png";
            imgName2 = @"5_2.png";
            imgName3 = @"5_3.png";
        }
        
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, OFFSET_Y, __MainScreen_Width, __MainScreen_Height)];
        img1.image = [UIImage imageNamed:imgName1];
        [m_scrollerview addSubview:img1];
      
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width, OFFSET_Y, __MainScreen_Width, __MainScreen_Height)];
        img2.image = [UIImage imageNamed:imgName2];
        [m_scrollerview addSubview:img2];
        
        UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width * 2, OFFSET_Y, __MainScreen_Width, __MainScreen_Height)];
        img3.image = [UIImage imageNamed:imgName3];
        [m_scrollerview addSubview:img3];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        btn.frame = CGRectMake(__MainScreen_Width*2+(__MainScreen_Width - 120)/2, __MainScreen_Height-70, 120, 38);
      
        [btn setTitle:@"开始" forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"go_home.png"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btntouched) forControlEvents:UIControlEventTouchUpInside];
        [m_scrollerview addSubview:btn];
        
        [self.window addSubview:m_scrollerview];
        [self.window addSubview:pageControl];
        NSArray *windows = [[UIApplication sharedApplication] windows];
        self.window.rootViewController=self.pageControl;
        
         [self.window makeKeyAndVisible];
        
 
    }
    else { 
        
         [self initfirstpage];
        
    }
    
    [self hsUpdateApp];
    
    return YES;
}

- (void) initfirstpage
{
   
    [NSThread sleepForTimeInterval:1.0f];
    [self gobtntouched:self];
    
 

}

- (void)btntouched
{
    if([m_scrollerview superview])
    {
        [m_scrollerview removeFromSuperview];
        [pageControl removeFromSuperview];
        Class VcClass = [[NSBundle mainBundle] classNamed:@"ViewController"];
        if (VcClass != NULL)
        {
            UIViewController *pVC =[[VcClass alloc] init];
            [self.window setRootViewController:pVC];
//            [self.window addSubview:pVC.view];
        }
    }
}


- (void)gobtntouched:(id)sender
{
   
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        /*UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.window.rootViewController];
        navigationController.navigationBarHidden = YES;
        self.window.rootViewController = navigationController;*/
        Class VcClass = [[NSBundle mainBundle] classNamed:@"ViewController"];
        if (VcClass != NULL)
        {
            UIViewController *pVC =[[VcClass alloc] init];
            self.window.rootViewController = pVC;
            //            [self.window addSubview:pVC.view];
            
        }
      [self.window makeKeyAndVisible];
    }
else
{
    [self.window makeKeyAndVisible];
}
/*
 
    if()
    {
        Class VcClass = [[NSBundle mainBundle] classNamed:@"ViewController"];
        if (VcClass != NULL)
        {
            UIViewController *pVC =[[VcClass alloc] init];
            [self.window setRootViewController:pVC];
            //            [self.window addSubview:pVC.view];
            
        }
        
        [self.window makeKeyAndVisible];
    }
    else
    {
        [self.window makeKeyAndVisible];
    }*/
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window
{
    // iPhone doesn't support upside down by default, while the iPad does.  Override to allow all orientations always, and let the root view controller decide what's allowed (the supported orientations mask gets intersected).
    return UIInterfaceOrientationMaskAll;
}

-(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    // NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //4当前版本号小于商店版本号,就更新
    
    
    if([currentVersion compare:appStoreVersion]==NSOrderedAscending )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
        [alert show];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //5实现跳转到应用商店进行更新
    if(buttonIndex==1)
    {
        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    }
} 
@end

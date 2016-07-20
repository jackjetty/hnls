//
//  ViewController.m
//  hlrs
//
//  Created by qimingyuan on 14/12/23.
//  Copyright (c) 2014年 qimingyuan. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "QSHelper.h"
@interface ViewController ()

@property (nonatomic, strong) MBProgressHUD* progress_;
@property (nonatomic, strong) UIWebView *m_webview;
@property (nonatomic, strong) NSString *appstoreurl;

@end

@implementation ViewController

@synthesize progress_;
@synthesize m_webview;
@synthesize appstoreurl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    m_webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, OFFSET_Y+20, __MainScreen_Width, __MainScreen_Height)];
//    m_webview = [[UIWebView alloc]initWithFrame:CGRectMake(100, 100, __MainScreen_Width/2, __MainScreen_Height/2)];
    m_webview.delegate = self;
    m_webview.tag = 10000;
    m_webview.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:UPDATEURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [m_webview loadRequest:request];
    [self.view addSubview:m_webview];
    m_webview.hidden = YES;
//    m_webview.backgroundColor = [UIColor redColor];
//    self.view.backgroundColor = [UIColor yellowColor];
    
    progress_ = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progress_];
    [self.view bringSubviewToFront:progress_];
    progress_.delegate = self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"should start loadwithrequest");
    
    NSLog(@"request.url = %@", request.URL);
    if([[NSString stringWithFormat:@"%@", request.URL] isEqualToString:UPDATEURL])
    {
        m_webview.hidden = YES;
        NSLog(@"hidden = yes");
    }
    else
    {
//        m_webview.hidden = NO;
        progress_.labelText = @"加载中...";
        [progress_ show:YES];
        NSLog(@"hidden = no");
    }
    
    
//    progress_.labelText = @"加载中...";
//    [progress_ show:YES];
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", request.URL];
  
    if([str hasSuffix:@".doc"] || [str hasSuffix:@".docx"] || [str hasSuffix:@".xls"] || [str hasSuffix:@".xlsx"])
    {
        NSLog(@"download file");
        
        NSURL *strurl = [NSURL URLWithString:str];
        
        [[UIApplication sharedApplication]openURL: strurl];
        
        if(progress_)
        {
            [progress_ show:NO];
            [progress_ hide:YES];
        }
        
        return NO;
    }
    
    if([str hasPrefix:@"tel:"])
    {
        
        NSLog(@"%@",str);
        
        [str insertString:@"//" atIndex:4];
        NSURL *strurl = [NSURL URLWithString:str];
        
        NSLog(@"strurl = %@",strurl);
        
        [[UIApplication sharedApplication]openURL: strurl];
        
        if(progress_)
        {
            [progress_ show:NO];
            [progress_ hide:YES];
        }
        
        return NO;
    }
    
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"did start load");
    
}

//versionCode 版本号
//versionName 版本名
//versionDescribe 更新说明
//forseUpdate 强制更新
//appStoreUrl 更新链接
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"did finish load");
    
    if([[NSString stringWithFormat:@"%@", webView.request.URL] isEqualToString:UPDATEURL])
    {
        NSString *lJs = @"document.documentElement.innerHTML";
        NSString *content = [webView stringByEvaluatingJavaScriptFromString:lJs];
        
//        NSLog(@"content = %@", content);
        
        NSRange range = [content rangeOfString:@"versionCode"];
        NSString *tmpcontent = [content substringFromIndex:range.location + range.length + 2];
        
//        NSLog(@"tmpcontent = %@", tmpcontent);
        
        range = [tmpcontent rangeOfString:@","];
        
        NSString *versionCode = [tmpcontent substringToIndex:range.location];
        
        NSLog(@"versioncode = %@",versionCode);
        
        
        range = [content rangeOfString:@"homeUrl"];
        tmpcontent = [content substringFromIndex:range.location + range.length + 3];
        range = [tmpcontent rangeOfString:@","];
        NSString *homeUrl = [tmpcontent substringToIndex:range.location - 1];
        [QSHelper setHomePage:homeUrl];
        
        
        range = [content rangeOfString:@"versionName"];
        tmpcontent = [content substringFromIndex:range.location + range.length + 3];
        range = [tmpcontent rangeOfString:@","];
        NSString *versionName = [tmpcontent substringToIndex:range.location - 1];
        NSLog(@"versionname = %@", versionName);
        
        range = [content rangeOfString:@"versionDescribe"];
        tmpcontent = [content substringFromIndex:range.location + range.length + 3];
        range = [tmpcontent rangeOfString:@","];
        NSString *versionDescribe = [tmpcontent substringToIndex:range.location - 1];
        NSLog(@"versionDescribe = %@", versionDescribe);
        
        range = [content rangeOfString:@"forseUpdate"];
        tmpcontent = [content substringFromIndex:range.location + range.length + 2];
        range = [tmpcontent rangeOfString:@","];
        NSString *forseUpdate = [tmpcontent substringToIndex:range.location];
        NSLog(@"forseUpdate = %@", forseUpdate);
        
        range = [content rangeOfString:@"appStoreUrl"];
        tmpcontent = [content substringFromIndex:range.location + range.length + 3];
        range = [tmpcontent rangeOfString:@","];
        NSString *appStoreUrl = [tmpcontent substringToIndex:range.location - 1];
        NSLog(@"appStoreUrl = %@", appStoreUrl);
        
        appstoreurl = [NSString stringWithFormat:@"%@",appStoreUrl];
        /*
        if([versionCode integerValue] > VERSIONCODE)
        {
 
            
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[versionDescribe componentsSeparatedByString:@"\\n"]];
            NSLog(@"array = %@",array);
            
            
            NSString *str = [array objectAtIndex:0];
            for(int i = 0; i < [array count]; i++)
            {
                if(i == 0)
                {
                    str = [NSString stringWithFormat:@"%@", [array objectAtIndex:i]];
                }
                else
                {
                    str = [NSString stringWithFormat:@"\n%@\n\n%@", str, [array objectAtIndex:i]];
                }
            }
            
            if([forseUpdate isEqualToString:@"true"] || [forseUpdate isEqualToString:@"TRUE"])
            {
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
//                [alertview addSubview:textview];
                alertview.tag = 10010;
                [self.view addSubview:alertview];
                [alertview show];
            }
            else
            {
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"版本升级" message:str delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"稍后更新", nil];
//                [alertview addSubview:textview];
                alertview.tag = 10010;
                [self.view addSubview:alertview];
                [alertview show];
            }
            
        }*/
       
        
        NSURL *url = [NSURL URLWithString:[QSHelper getHomePage]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [m_webview loadRequest:request];
    }
    else
    {
        m_webview.hidden = NO;
        if(progress_)
        {
            [progress_ show:NO];
            [progress_ hide:YES];
        }
    }
    
    

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"did fail load with error");
    
    if(progress_)
    {
        [progress_ show:NO];
        [progress_ hide:YES];
    }
    NSLog(@"url = %@", [NSString stringWithFormat:@"%@", webView.request.URL]);
    
    if([[NSString stringWithFormat:@"%@", webView.request.URL] isEqualToString:UPDATEURL])
    {
        NSLog(@"webview.content = %@", webView);
        NSURL *url = [NSURL URLWithString:[QSHelper getHomePage]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [m_webview loadRequest:request];
    }
    else
    {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"联网失败，请检查网络" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"重试", nil];
        alertview.tag = 10011;
        [self.view addSubview:alertview];
        [alertview show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            if(alertView.tag == 10011)
            {
                exit(0);
            }
            else
            {
                NSLog(@"立即更新");
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:appstoreurl]];
            }
        }
            break;
        case 1:
        {
            if(alertView.tag == 10011)
            {
                if([[NSString stringWithFormat:@"%@", m_webview.request.URL] length] == 0)
                {
                    NSURL *url = [NSURL URLWithString:[QSHelper getHomePage]];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    [m_webview loadRequest:request];
                }
                else
                {
                    [m_webview reload];
                }
            }
            else
            {
                NSLog(@"稍后更新");
            }
        }
            break;
            
        default:
            break;
    }
}

//UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
//UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
//UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
//UIDeviceOrientationLandscapeRight

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    
//    // Return YES for supported orientations
//    
//    return (interfaceOrientation != UIDeviceOrientationPortraitUpsideDown);
//    
//}

-(NSUInteger)supportedInterfaceOrientations{
    NSLog(@"supportedInterfaceOrientations");
    
    CGRect frame = m_webview.frame;
    
    if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft)
    {
        NSLog(@"UIDeviceOrientationLandscapeLeft");
//        CGRectMake(0, OFFSET_Y+20, __MainScreen_Width, __MainScreen_Height)
        frame.origin.x = OFFSET_Y;
        frame.origin.y = 0;
        frame.size.width = __MainScreen_Height;
        frame.size.height = __MainScreen_Width;
    }
    else if([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"UIDeviceOrientationLandscapeRight");
        frame.origin.x = OFFSET_Y + 20;
        frame.origin.y = 0;
        frame.size.width = __MainScreen_Height;
        frame.size.height = __MainScreen_Width;
    }
    else if([[UIDevice currentDevice]orientation] == UIDeviceOrientationPortrait)
    {
        NSLog(@"UIDeviceOrientationPortrait");
        frame.origin.x = 0;
        frame.origin.y = OFFSET_Y + 20;
        frame.size.width = __MainScreen_Width;
        frame.size.height = __MainScreen_Height;
    }
    m_webview.frame = frame;
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate
{
//    NSLog(@"shouldautorotate");
//    return YES;
    return NO;
}

//未调用
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    NSLog(@"willRotateToInterfaceOrientation");
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    NSLog(@"didRotateFromInterfaceOrientation");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

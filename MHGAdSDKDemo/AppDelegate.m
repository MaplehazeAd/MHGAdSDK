//
//  AppDelegate.m
//  MHGAdSDKDemo
//
//  Created by Jianheng on 2025/1/13.
//

#import "AppDelegate.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <MHGAdSDK/MHGAdSDK.h>

#import "MHMainViewController.h"
#import "UIView+toast.h"
#include <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()<MHGSplashAdDelegete>

@property (nonatomic, strong) MHGSplashAd *splashAd;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor colorWithRed:226/255.0 green:142/255.0 blue:100/255.0 alpha:1];
        [UINavigationBar appearance].standardAppearance = appearance;
        [UINavigationBar appearance].scrollEdgeAppearance = appearance;
        [UINavigationBar appearance].compactAppearance = appearance;
    } else {
        // Fallback on earlier versions
        [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
        [[UINavigationBar appearance] setTranslucent:NO];
        [[UINavigationBar appearance] setTitleTextAttributes:@{
            NSForegroundColorAttributeName: [UIColor whiteColor]
        }];
    }

    
    [self configMHAd];

    // Execute code block after a delay
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Delayed execution code
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager requestWhenInUseAuthorization];
        
        if (@available(iOS 14, *)) {
            // iOS 14
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                    [[MHGAdManager sharedManager] registerApp];
                } else {
                    [[MHGAdManager sharedManager] registerApp];
                }
            }];
        } else {
            // Fallback on earlier versions
            [[MHGAdManager sharedManager] registerApp];
        }
    });
    
    [self showMianVC];

    
    return YES;
}


- (void)configMHAd {
    [MHGAdConfiguration sharedConfig].appID = @"210038";
    [MHGAdConfiguration sharedConfig].allowShake = NO;
    [MHGAdConfiguration sharedConfig].allowLocation = YES;
}

- (void)showMianVC {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MHMainViewController * vc = [[MHMainViewController alloc]init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
}

- (void)loadSplashAd {
    self.splashAd = [[MHGSplashAd alloc] initWithPlacementID:@"210012"];
    self.splashAd.delegate = self;
    [self.splashAd loadAd];
}



- (UIImage *)getAppIcon {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *iconsDictionary = infoDictionary[@"CFBundleIcons"];
    NSDictionary *primaryIconsDictionary = iconsDictionary[@"CFBundlePrimaryIcon"];
    NSArray *iconFiles = primaryIconsDictionary[@"CFBundleIconFiles"];
    NSString *iconName = [iconFiles lastObject];
    return [UIImage imageNamed:iconName];
}


#pragma mark - MHGSplashAdDelegete

- (void)splashAdDidLoad:(MHGSplashAd *)splashAd placementID:(NSString *)placementID
{
    UILabel *customSkipLabel = [[UILabel alloc] init];
    customSkipLabel.tag = 1301;
    customSkipLabel.text = @"Close";
    customSkipLabel.userInteractionEnabled = YES;
    [customSkipLabel sizeToFit];
    customSkipLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
    customSkipLabel.shadowColor = [UIColor grayColor];
    customSkipLabel.textColor = [UIColor whiteColor];
    customSkipLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - customSkipLabel.frame.size.width - 10,
                                       50,
                                       customSkipLabel.frame.size.width,
                                       customSkipLabel.frame.size.height);
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[self getAppIcon]];
    logoImageView.frame = CGRectMake(0, 0, 80, 80);
    logoImageView.center = bottomView.center;
    [bottomView addSubview:logoImageView];
    
    [self.splashAd sendWinNotification:100];
    

    [splashAd showInWindow:[UIApplication sharedApplication].keyWindow
             withBottomView: bottomView
                   skipView: nil];


}

- (void)splashAdLoadFailed:(MHGSplashAd *)splashAd errorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage
{
    UIView * view = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    [view makeToast:errorMessage duration:2.0F position:CSToastPositionCenter];
}

- (void)splashAdDidAppear:(MHGSplashAd * _Nullable)splashAd placementID:(NSString * _Nullable)placementID {
    NSLog(@"AppDelegate splashAdDidAppear");
}

- (void)splashAdDidClicked:(MHGSplashAd * _Nullable)splashAd placementID:(NSString * _Nullable)placementID {
    NSLog(@"AppDelegate splashAdDidClicked");
}


- (void)splashAdDidDisappear:(MHGSplashAd * _Nullable)splashAd placementID:(NSString * _Nullable)placementID {
    NSLog(@"AppDelegate splashAdDidDisappear");
}



@end

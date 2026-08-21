# **Maplehaze Global iOS SDK — Integration Guide**



# **SDK Information**

SDK Name: Maplehaze Global iOS SDK

Developer: Maplehaze Group Ltd.

Main Features: Ad delivery, performance data monitoring

Version: 1.0.0

Operations: operation@maplehaze.com

Source: https://github.com/MaplehazeAd/MHGAdSDK

Privacy Policy: [Maplehaze Group SDK Privacy Policy](https://maplehaze.com/sdk/privacy_policy.html)



# **Changelog**

| **Version** | **Changes** | **Date** |
| ----------- | ----------- | -------- |
| 1.0.0       | 1. Initial release<br />2. Supports Splash, Rewarded Video, Native, and Interstitial ad formats<br />3. Supports Google AdMob integration<br />4. Supports CocoaPods integration | 2026.08.21 |



# I. Prerequisites

Download the latest iOS SDK and Demo project from the repository. We strongly recommend reviewing the Demo project code before integrating the SDK into your app.

**Environment Requirements:**

- iOS 13.0 or later
- Xcode 14.0 or later
- CocoaPods 1.10.0 or later



# II. Ad Placement Setup

Ad placements are not yet available for self-service creation. Please contact your account manager to set up your media and ad placements. You will need to provide: app name, bundle ID, number of ad placements needed, and the name and type of each placement.

The SDK currently supports **Splash**, **Rewarded Video**, **Native**, and **Interstitial** ad types.



# III. Integration

## 1. CocoaPods Integration

Add the following to your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.0'

target 'YourAppTarget' do
  use_frameworks!

  # Maplehaze Global Ad SDK
  pod 'MHGAdSDK', '~> 1.0.0'

  # Google AdMob SDK (required)
  pod 'Google-Mobile-Ads-SDK', '~> 13.5.0'
end
```

Then run:

```bash
pod install
```



## 2. Configure Info.plist

Configure App Transport Security and user tracking permission:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to provide localized services.</string>
```

### Google AdMob Configuration

You must also configure the Google AdMob App ID in your `Info.plist`:

```xml
<key>GADApplicationIdentifier</key>
<string>YOUR_ADMOB_APP_ID</string>
```

### SKAdNetwork Configuration

Add the required SKAdNetwork identifiers for ad attribution tracking. Refer to the [Google AdMob documentation](https://developers.google.com/admob/ios/ios14) for the latest list of SKAdNetwork IDs.



## 3. Initialize the SDK

Initialize the SDK in `AppDelegate`:

```objective-c
#import <MHGAdSDK/MHGAdSDK.h>

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Configure MHGAdSDK
    [self configMHGAd];

    // Register and initialize the SDK
    [[MHGAdManager sharedManager] registerApp];

    NSLog(@"MHGAdSDK version: %@", [[MHGAdManager sharedManager] version]);
    return YES;
}

- (void)configMHGAd {
    // Required: Set your App ID
    [MHGAdConfiguration sharedConfig].appID = @"YOUR_APP_ID";

    // Optional: Debug mode (outputs logs). Default is NO.
    [MHGAdConfiguration sharedConfig].isDebug = YES;

    // Optional: Allow shake gesture. Default is NO.
    [MHGAdConfiguration sharedConfig].allowShake = NO;

    // Optional: Allow SDK to access location. Default is YES.
    [MHGAdConfiguration sharedConfig].allowLocation = NO;

    // Optional: Personalized ads. 0 = enabled (default), 1 = disabled.
    // [MHGAdConfiguration sharedConfig].personalizedState = 0;
}
```



## 4. Load and Display Ads

### 1) Splash Ad

**Load a splash ad:**

```objective-c
#import <MHGAdSDK/MHGAdSDK.h>

@interface SplashViewController () <MHGSplashAdDelegete>
@property (nonatomic, strong) MHGSplashAd *splashAd;
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.splashAd = [[MHGSplashAd alloc] initWithPlacementID:@"YOUR_PLACEMENT_ID"];
    self.splashAd.delegate = self;
    // Important: rootController is required for presenting ad or landing page
    self.splashAd.rootController = self;
    [self.splashAd loadAd];
}

@end
```

**Display the splash ad:**

```objective-c
- (void)splashAdDidLoad:(MHGSplashAd *)splashAd
            placementID:(NSString *)placementID
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
        [UIScreen mainScreen].bounds.size.width, 120)];
    bottomView.backgroundColor = [UIColor whiteColor];

    [self.splashAd showInWindow:[UIApplication sharedApplication].keyWindow
                 withBottomView:bottomView
                       skipView:nil];
}
```

**Implement the splash ad delegate:**

```objective-c
#pragma mark - MHGSplashAdDelegete

- (void)splashAdDidLoad:(MHGSplashAd *)splashAd
            placementID:(NSString *)placementID
{
    NSLog(@"Splash ad loaded");
}

- (void)splashAdLoadFailed:(MHGSplashAd *)splashAd
                 errorCode:(NSInteger)errorCode
              errorMessage:(NSString *)errorMessage
{
    NSLog(@"Splash ad load failed: %ld - %@", (long)errorCode, errorMessage);
}

- (void)splashAdDidAppear:(MHGSplashAd *)splashAd
              placementID:(NSString *)placementID
{
    NSLog(@"Splash ad appeared");
}

- (void)splashAdDidClicked:(MHGSplashAd *)splashAd
               placementID:(NSString *)placementID
{
    NSLog(@"Splash ad clicked");
}

- (void)splashAdDidDisappear:(MHGSplashAd *)splashAd
                 placementID:(NSString *)placementID
{
    NSLog(@"Splash ad disappeared");
}
```

**Splash ad bidding:**

```objective-c
- (void)splashAdDidLoad:(MHGSplashAd *)splashAd
            placementID:(NSString *)placementID
{
    NSInteger ecpm = [splashAd ecpm];
    NSLog(@"Splash eCPM: %ld", (long)ecpm);

    // If using this ad, report win with the clearing price
    [splashAd sendWinNotification:ecpm];

    // If not using this ad, report loss
    // [splashAd sendLossNotification:0];
}
```



### 2) Rewarded Video Ad

**Load a rewarded video ad:**

```objective-c
#import <MHGAdSDK/MHGAdSDK.h>

@interface RewardVideoViewController () <MHGRewardedVideoAdDelegete>
@property (nonatomic, strong) MHGRewardedVideoAd *rewardedVideoAd;
@end

@implementation RewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.rewardedVideoAd = [[MHGRewardedVideoAd alloc] initWithPlacementID:@"YOUR_PLACEMENT_ID"];
    self.rewardedVideoAd.isMuted = YES;
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAd];
}

@end
```

**Display the rewarded video ad:**

```objective-c
BOOL isShow = [self.rewardedVideoAd showAdFromRootViewController:self];
```

**Implement the rewarded video ad delegate:**

```objective-c
#pragma mark - MHGRewardedVideoAdDelegete

- (void)rewardedVideoAdVideoDidLoad:(MHGRewardedVideoAd *)rewardedVideoAd
                        placementID:(NSString *)placementID
{
    NSLog(@"Rewarded video loaded");
    [self.rewardedVideoAd showAdFromRootViewController:self];
}

- (void)rewardedVideoAdVideoLoadFailed:(MHGRewardedVideoAd *)rewardedVideoAd
                           placementID:(NSString *)placementID
                             errorCode:(NSInteger)errorCode
                          errorMessage:(NSString *)errorMessage
{
    NSLog(@"Rewarded video load failed: %ld - %@", (long)errorCode, errorMessage);
}

- (void)rewardedVideoAdDidAppear:(MHGRewardedVideoAd *)rewardedVideoAd
                     placementID:(NSString *)placementID
{
    NSLog(@"Rewarded video appeared");
}

- (void)rewardedVideoAdDidDisappear:(MHGRewardedVideoAd *)rewardedVideoAd
                        placementID:(NSString *)placementID
{
    NSLog(@"Rewarded video disappeared");
}

- (void)rewardedVideoAdDidClicked:(MHGRewardedVideoAd *)rewardedVideoAd
                      placementID:(NSString *)placementID
{
    NSLog(@"Rewarded video clicked");
}

- (void)rewardedVideoAdVideoDidRewarded:(MHGRewardedVideoAd *)rewardedVideoAd
                                 result:(BOOL)success
                            placementID:(NSString *)placementID
{
    NSLog(@"Rewarded video reward result: %d", success);
}

- (void)rewardedVideoAdVideoDidFinished:(MHGRewardedVideoAd *)rewardedVideoAd
                            placementID:(NSString *)placementID
{
    NSLog(@"Rewarded video finished");
}
```

**Rewarded video bidding:**

```objective-c
- (void)rewardedVideoAdVideoDidLoad:(MHGRewardedVideoAd *)rewardedVideoAd
                        placementID:(NSString *)placementID
{
    NSInteger ecpm = [rewardedVideoAd ecpm];

    // Report win
    [rewardedVideoAd sendWinNotification:ecpm];
    // Report loss
    // [rewardedVideoAd sendLossNotification:0];
}
```



### 3) Native Ad

**Load a native ad:**

```objective-c
#import <MHGAdSDK/MHGAdSDK.h>

@interface NativeViewController () <MHGNativeAdDelegete>
@property (nonatomic, strong) MHGNativeAd *nativeAd;
@end

@implementation NativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MHGNativeAdConfiguration *config = [[MHGNativeAdConfiguration alloc] init];
    config.placementID = @"YOUR_PLACEMENT_ID";
    config.isMuted = YES;
    config.isVideoAutoPlayWithMobileNetwork = NO;

    self.nativeAd = [[MHGNativeAd alloc] initWithConfiguration:config];
    self.nativeAd.delegate = self;
    self.nativeAd.rootController = self;
    [self.nativeAd loadAd];
}

@end
```

**Display a native ad:**

```objective-c
- (void)nativeAdDidLoad:(MHGNativeAd *)nativeAd
            placementID:(NSString *)placementID
         nativeAdModels:(NSArray<MHGNativeAdModel *> *)nativeAdModels
{
    if (nativeAdModels.count == 0) return;

    MHGNativeAdModel *model = nativeAdModels.firstObject;

    // 1. Create MHGNativeAdView
    MHGNativeAdView *adView = [[MHGNativeAdView alloc] initWithFrame:adFrame];
    adView.nativeAdModel = model;

    // 2. Bind UI elements
    MHGNativePrepareInfo *info = [MHGNativePrepareInfo loadPrepareInfo:^(MHGNativePrepareInfo *config) {
        config.titleLabel = titleLabel;
        config.ctaLabel = ctaLabel;
        config.iconImageView = iconImageView;
        config.mainImageView = mainImageView;
        config.mediaView = [adView getMediaView];
    }];
    [adView prepareWithNativePrepareInfo:info];

    // 3. Register clickable views
    [adView registerClickableViewArray:@[adView]];

    // 4. Add to view hierarchy
    [self.view addSubview:adView];
}
```

**Unregister the native ad:**

```objective-c
[self.nativeAd unregisterView];
```

**Implement the native ad delegate:**

```objective-c
#pragma mark - MHGNativeAdDelegete

- (void)nativeAdDidLoad:(MHGNativeAd *)nativeAd
            placementID:(NSString *)placementID
         nativeAdModels:(NSArray<MHGNativeAdModel *> *)nativeAdModels
{
    NSLog(@"Native ad loaded, count: %lu", (unsigned long)nativeAdModels.count);
}

- (void)nativeAdLoadFailed:(MHGNativeAd *)nativeAd
               placementID:(NSString *)placementID
                 errorCode:(NSInteger)errorCode
              errorMessage:(NSString *)errorMessage
{
    NSLog(@"Native ad load failed: %ld - %@", (long)errorCode, errorMessage);
}

- (void)nativeAdDidAppear:(MHGNativeAd *)nativeAd
              placementID:(NSString *)placementID
                   adView:(MHGNativeAdView *)adView
            nativeAdModel:(MHGNativeAdModel *)nativeAdModel
{
    NSLog(@"Native ad appeared");
}

- (void)nativeAdDidClick:(MHGNativeAd *)nativeAd
             placementID:(NSString *)placementID
                  adView:(MHGNativeAdView *)adView
           nativeAdModel:(MHGNativeAdModel *)nativeAdModel
{
    NSLog(@"Native ad clicked");
}
```

**MHGNativeAdModel properties:**

| Property | Type | Description |
| -------- | ---- | ----------- |
| `title` | `NSString *` | Ad title |
| `description` | `NSString *` | Ad description |
| `actionText` | `NSString *` | Call-to-action text |
| `iconURL` | `NSString *` | Ad icon URL |
| `imageURL` | `NSString *` | Main image URL |
| `imageWidth` | `NSInteger` | Image/video width |
| `imageHeight` | `NSInteger` | Image/video height |
| `isVideoAd` | `BOOL` | Whether the ad contains video |
| `ecpm` | `NSInteger` | eCPM value for bidding |
| `coupon` | `MHGNativeAdCouponModel *` | Coupon info (if available) |

**Native ad bidding:**

```objective-c
- (void)nativeAdDidLoad:(MHGNativeAd *)nativeAd
            placementID:(NSString *)placementID
         nativeAdModels:(NSArray<MHGNativeAdModel *> *)nativeAdModels
{
    MHGNativeAdModel *model = nativeAdModels.firstObject;
    NSInteger ecpm = model.ecpm;

    // Report win
    [model sendWinNotification:ecpm];
    // Report loss
    // [model sendLossNotification:0];
}
```



### 4) Interstitial Ad

**Load an interstitial ad:**

```objective-c
#import <MHGAdSDK/MHGAdSDK.h>

@interface InterstitialViewController () <MHGInterstitialAdDelegete>
@property (nonatomic, strong) MHGInterstitialAd *interstitialAd;
@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.interstitialAd = [[MHGInterstitialAd alloc] initWithPlacementID:@"YOUR_PLACEMENT_ID"];
    self.interstitialAd.videoMuted = YES;
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];
}

@end
```

**Display the interstitial ad:**

```objective-c
[self.interstitialAd presentFromRootViewController:self];
```

**Implement the interstitial ad delegate:**

```objective-c
#pragma mark - MHGInterstitialAdDelegete

- (void)interstitialAdDidLoad:(MHGInterstitialAd *)interstitialAd
                  placementID:(NSString *)placementID
{
    NSLog(@"Interstitial ad loaded");
    [self.interstitialAd presentFromRootViewController:self];
}

- (void)interstitialAdLoadFailed:(MHGInterstitialAd *)interstitialAd
                     placementID:(NSString *)placementID
                       errorCode:(NSInteger)errorCode
                    errorMessage:(NSString *)errorMessage
{
    NSLog(@"Interstitial ad load failed: %ld - %@", (long)errorCode, errorMessage);
}

- (void)interstitialAdDidAppear:(MHGInterstitialAd *)interstitialAd
                    placementID:(NSString *)placementID
{
    NSLog(@"Interstitial ad appeared");
}

- (void)interstitialAdDidDisappear:(MHGInterstitialAd *)interstitialAd
                       placementID:(NSString *)placementID
{
    NSLog(@"Interstitial ad disappeared");
}

- (void)interstitialAdDidClicked:(MHGInterstitialAd *)interstitialAd
                     placementID:(NSString *)placementID
{
    NSLog(@"Interstitial ad clicked");
}
```

**Interstitial ad bidding:**

```objective-c
- (void)interstitialAdDidLoad:(MHGInterstitialAd *)interstitialAd
                  placementID:(NSString *)placementID
{
    NSInteger ecpm = [interstitialAd ecpm];

    // Report win
    [interstitialAd sendWinNotification:ecpm];
    // Report loss
    // [interstitialAd sendLossNotification:0];
}
```



## 5. Notes

- **Permissions:** Add `NSUserTrackingUsageDescription` in Info.plist to request user tracking permission (required for IDFA).
- **Network:** Ensure `NSAppTransportSecurity` allows the necessary network connections.
- **Placement ID:** Use the correct placement ID provided by your account manager.
- **Google AdMob:** Make sure to configure `GADApplicationIdentifier` in Info.plist and integrate the Google Mobile Ads SDK as a dependency.



## 6. Error Codes

| **Error Code** | **Description** |
| -------------- | --------------- |
| 0 | Ad request successful |
| 100001 | Parameter not URL-encoded. Please encode parameters before sending. |
| 107006 | app_bundle_id does not match. Update to the correct bundle ID. |
| 107005 | app_id does not match. Update to the correct media ID. |
| 100007 | pos_id does not match. Update to the correct placement ID. |
| 100135 | Ad placement is disabled. Contact your account manager. |
| 102006 | Request is valid but no matching ad was found. |
| 102012 | Daily request quota exceeded. Contact operations to increase quota. |




//
//  MHGSplashAd.h
//  MHGAdSDK
//
//  Created by Abenx on 2021/12/6.
//

#import <UIKit/UIKit.h>
#import "MHAdExtraInfo.h"

@class MHGSplashAd;

/// Splash ad delegate
@protocol MHGSplashAdDelegete <NSObject>

/// Splash ad did load
- (void)splashAdDidLoad:(MHGSplashAd * _Nullable)splashAd
            placementID:(NSString *_Nullable)placementID;

/// Splash ad load failed
- (void)splashAdLoadFailed:(MHGSplashAd * _Nullable)splashAd
                 errorCode:(NSInteger)errorCode
              errorMessage:(NSString *_Nullable)errorMessage;

/// Splash ad did appear
- (void)splashAdDidAppear:(MHGSplashAd * _Nullable)splashAd
              placementID:(NSString * _Nullable)placementID;

/// Splash ad did clicked
- (void)splashAdDidClicked:(MHGSplashAd * _Nullable)splashAd
               placementID:(NSString * _Nullable)placementID;

/// Splash ad did disappear
- (void)splashAdDidDisappear:(MHGSplashAd * _Nullable)splashAd
                      placementID:(NSString * _Nullable)placementID;

/// 开屏广告进入全屏广告
- (void)splashAdDidPresentFullScreen:(MHGSplashAd * _Nullable)splashAd
                         placementID:(NSString *_Nullable)placementID;

/// 开屏广告离开全屏广告
- (void)splashAdDidDismissFullScreen:(MHGSplashAd * _Nullable)splashAd
                         placementID:(NSString *_Nullable)placementID;


@end

NS_ASSUME_NONNULL_BEGIN




@interface MHGSplashAd : NSObject

@property (nonatomic, weak) id<MHGSplashAdDelegete> delegate;


- (instancetype)initWithPlacementID:(NSString * _Nonnull)placementID;

@property (nonatomic, assign)CGSize viewSize;

@property (nonatomic, weak) UIViewController * rootController;

/// load ad
- (void)loadAd;

/// show
- (BOOL)showInWindow:(UIWindow * _Nullable)window
      withBottomView:(UIView * _Nullable)bottomView
            skipView:(UIView * _Nullable)skipView;

// get current ecpm
- (NSInteger)ecpm;

// send win
- (void)sendWinNotification:(NSInteger)ecpm;

// send loss
- (void)sendLossNotification:(NSInteger)ecpm;

- (MHAdExtraInfo *)getExtraInfo;

@end

NS_ASSUME_NONNULL_END

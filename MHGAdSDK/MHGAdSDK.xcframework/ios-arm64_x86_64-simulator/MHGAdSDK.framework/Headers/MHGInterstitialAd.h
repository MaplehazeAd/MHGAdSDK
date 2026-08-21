//
//  MHGInterstitialAd.h
//  MHGAdSDK
//
//  Created by 郭建恒 on 2026/5/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MHGInterstitialAd;

/// MHGNativeAdDelegete
@protocol MHGInterstitialAdDelegete <NSObject>

@optional
/// Interstitial ad did load
- (void)interstitialAdDidLoad:(MHGInterstitialAd *)interstitialAd
                  placementID:(NSString *_Nullable)placementID;
/// Interstitial ad load failed
- (void)interstitialAdLoadFailed:(MHGInterstitialAd * _Nullable)interstitialAd
                     placementID:(NSString *_Nullable)placementID
                       errorCode:(NSInteger)errorCode
                    errorMessage:(NSString *_Nullable)errorMessage;
/// Interstitial ad did appear
- (void)interstitialAdDidAppear:(MHGInterstitialAd * _Nullable)interstitialAd
                    placementID:(NSString * _Nullable)placementID;

/// Interstitial ad did disappear
- (void)interstitialAdDidDisappear:(MHGInterstitialAd * _Nullable)interstitialAd
                       placementID:(NSString * _Nullable)placementID;

/// Splash ad did clicked
- (void)interstitialAdDidClicked:(MHGInterstitialAd *)interstitialAd
                     placementID:(NSString * _Nullable)placementID;
//
@end

@interface MHGInterstitialAd : NSObject


/// delegate
@property (nonatomic, weak) id<MHGInterstitialAdDelegete> delegate;

/// muted
@property (nonatomic, assign) BOOL videoMuted;

- (instancetype)initWithPlacementID:(NSString * _Nonnull)placementID;

/// load ad
- (void)loadAd;

/// show
- (void)presentFromRootViewController:(UIViewController * _Nonnull)rootViewController;

// get current ecpm
- (NSInteger)ecpm;

// send win
- (void)sendWinNotification:(NSInteger)ecpm;

// send loss
- (void)sendLossNotification:(NSInteger)ecpm;

@end

NS_ASSUME_NONNULL_END

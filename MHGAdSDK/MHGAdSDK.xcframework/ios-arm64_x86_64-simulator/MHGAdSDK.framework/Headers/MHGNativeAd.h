//
//  MHNativeAd.h
//  MHGAdSDK
//
//  Created by Abenx on 2021/9/8.
//

#import <UIKit/UIKit.h>
#import "MHGNativeAdConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@class MHGNativeAdView, MHGNativeAdModel, MHGNativeAd;

/// MHGNativeAdDelegete
@protocol MHGNativeAdDelegete <NSObject>

// Native ad did load
- (void)nativeAdDidLoad:(MHGNativeAd *)nativeAd
            placementID:(NSString *)placementID
         nativeAdModels:(NSArray<MHGNativeAdModel *> *)nativeAdModels;

// Native ad load failed
- (void)nativeAdLoadFailed:(MHGNativeAd *)nativeAd
               placementID:(NSString *)placementID
                 errorCode:(NSInteger)errorCode
              errorMessage:(NSString *)errorMessage;

// Native ad did appear
- (void)nativeAdDidAppear:(MHGNativeAd *)nativeAd
              placementID:(NSString *)placementID
                   adView:(MHGNativeAdView *)adView
            nativeAdModel:(MHGNativeAdModel *)nativeAdModel;

// Native ad did clicked
- (void)nativeAdDidClick:(MHGNativeAd *)nativeAd
             placementID:(NSString *)placementID
                  adView:(MHGNativeAdView *)adView
           nativeAdModel:(MHGNativeAdModel *)nativeAdModel;

/// for video ad
// Native ad play start
- (void)nativeAdPlayStart:(MHGNativeAd *)nativeAd
              placementID:(NSString *)placementID
                   adView:(MHGNativeAdView *)adView
            nativeAdModel:(MHGNativeAdModel *)nativeAdModel;

// Native ad play end
- (void)nativeAdPlayFinish:(MHGNativeAd *)nativeAd
              placementID:(NSString *)placementID
                   adView:(MHGNativeAdView *)adView
            nativeAdModel:(MHGNativeAdModel *)nativeAdModel;

/// 广告详情页已展示。
- (void)nativeAdDetailViewDidAppear:(MHGNativeAd *)nativeAd
                        placementID:(NSString *)placementID
                             adView:(MHGNativeAdView *)adView
                      nativeAdModel:(MHGNativeAdModel *)nativeAdModel;

/// 广告详情页已关闭。
- (void)nativeAdDetailViewDidClose:(MHGNativeAd *)nativeAd
                       placementID:(NSString *)placementID
                            adView:(MHGNativeAdView *)adView
                     nativeAdModel:(MHGNativeAdModel *)nativeAdModel;

@end

@interface MHGNativeAd : NSObject

/// delegate
@property (nonatomic, weak) id<MHGNativeAdDelegete> delegate;

/// rootViewController
@property (nonatomic, weak) UIViewController * rootController;

- (instancetype)initWithConfiguration:(MHGNativeAdConfiguration *)configuration;

/// load ad
- (void)loadAd;

// render ad
- (void)rendererWithRenderView:(UIView *_Nullable)renderView
                  nativeADView:(MHGNativeAdView *)nativeADView;

// unregist ad
- (void)unregisterView;

@end

NS_ASSUME_NONNULL_END

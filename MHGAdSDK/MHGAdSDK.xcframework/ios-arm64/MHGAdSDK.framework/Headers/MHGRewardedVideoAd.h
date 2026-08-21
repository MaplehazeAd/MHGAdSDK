//
//  MHGRewardedVideoAd.h
//  MHGAdSDK
//
//  Created by Abenx on 2021/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MHGRewardedVideoAd;

/// rewarded video ad delegete
@protocol MHGRewardedVideoAdDelegete <NSObject>

/// rewarded video ad did load
- (void)rewardedVideoAdVideoDidLoad:(MHGRewardedVideoAd *)rewardedVideoAd
                        placementID:(NSString *)placementID;

/// rewarded video ad load failed
- (void)rewardedVideoAdVideoLoadFailed:(MHGRewardedVideoAd *)rewardedVideoAd
                           placementID:(NSString *)placementID
                             errorCode:(NSInteger)errorCode
                          errorMessage:(NSString *)errorMessage;

/// rewarded video ad will appear
- (void)rewardedVideoAdWillAppear:(MHGRewardedVideoAd *)rewardedVideoAd
                      placementID:(NSString *)placementID;

/// rewarded video ad did appear
- (void)rewardedVideoAdDidAppear:(MHGRewardedVideoAd *)rewardedVideoAd
                     placementID:(NSString *)placementID;


/// rewarded video ad did disappear
- (void)rewardedVideoAdDidDisappear:(MHGRewardedVideoAd *)rewardedVideoAd
                        placementID:(NSString *)placementID;

/// rewarded video ad did clicked
- (void)rewardedVideoAdDidClicked:(MHGRewardedVideoAd *)rewardedVideoAd
                      placementID:(NSString *)placementID;

/// rewarded video ad did rewarded
- (void)rewardedVideoAdVideoDidRewarded:(MHGRewardedVideoAd *)rewardedVideoAd
                                 result:(BOOL)success
                            placementID:(NSString *)placementID;

/// rewarded video ad did finished
- (void)rewardedVideoAdVideoDidFinished:(MHGRewardedVideoAd *)rewardedVideoAd
                            placementID:(NSString *)placementID;

@end


@interface MHGRewardedVideoAd : NSObject

/// delegate
@property (nonatomic, weak) id<MHGRewardedVideoAdDelegete> delegate;

/// muted
@property (nonatomic, assign) BOOL isMuted;


- (instancetype)initWithPlacementID:(NSString * _Nonnull)placementID;

/// load ad
- (void)loadAd;

/// display ad
- (BOOL)showAdFromRootViewController:(UIViewController * _Nonnull)rootViewController;

// get current ecpm
- (NSInteger)ecpm;

// send win notification
- (void)sendWinNotification:(NSInteger)ecpm;

// send loss notification
- (void)sendLossNotification:(NSInteger)ecpm;


@end


NS_ASSUME_NONNULL_END

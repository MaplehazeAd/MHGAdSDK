//
//  MHGAdConfiguration.h
//  MHGAdSDK
//
//  Created by Jianheng on 2025/3/5.
//

#import <Foundation/Foundation.h>
#import "MHGAdPublicEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHGAdConfiguration : NSObject

// Please use the singleton to initialize configuration items
+ (instancetype)sharedConfig;

/// The media ID.
@property(nonatomic, copy) NSString * appID;

// Whether to allow shake gesture
@property(nonatomic, assign) BOOL allowShake;

// Whether to allow SDK debug toast
@property(nonatomic, assign) BOOL allowToast;

// Whether to allow fetching the locally installed app list
@property(nonatomic, assign) BOOL allowGetAppList;

// Whether to allow the SDK to access location information, default is YES
@property(nonatomic, assign) BOOL allowLocation;

// In debug mode, logs will be output. Default is NO. Set to YES if logs are needed.
@property(nonatomic, assign) BOOL isDebug;


@property(nonatomic, assign) BOOL isReleaseEnv; //

// Developer mode. Default is NO.
@property(nonatomic, assign) BOOL isDeveloperMode;

/// Personalized ad recommendation. 0-enabled (default), 1-disabled.
@property(nonatomic, assign) NSInteger personalizedState;

#pragma mark - Google AdMob Configuration

/// Max ad content rating for Google ads. Default MHGMaxAdContentRatingGeneral.
/// Maps to GADRequestConfiguration.maxAdContentRating
@property(nonatomic, assign) MHGMaxAdContentRating googleMaxAdContentRating;

/// Test device identifiers that always receive test ads.
/// Maps to GADRequestConfiguration.testDeviceIdentifiers
@property(nonatomic, copy, nullable) NSArray<NSString *> *googleTestDeviceIdentifiers;

/// Tag for under age of consent (GDPR). @YES / @NO / nil (unset).
/// Maps to GADRequestConfiguration.tagForUnderAgeOfConsent
@property(nonatomic, copy, nullable) NSNumber *googleTagForUnderAgeOfConsent;

/// Tag for child-directed treatment (COPPA). @YES / @NO / nil (unset).
/// Maps to GADRequestConfiguration.tagForChildDirectedTreatment
@property(nonatomic, copy, nullable) NSNumber *googleTagForChildDirectedTreatment;

/// Publisher first-party ID enabled. Default YES.
/// Maps to GADRequestConfiguration setPublisherFirstPartyIDEnabled:
@property(nonatomic, assign) BOOL googlePublisherFirstPartyIDEnabled;

/// Publisher privacy personalization state. Default MHGPublisherPrivacyPersonalizationStateDefault.
/// Maps to GADRequestConfiguration.publisherPrivacyPersonalizationState
@property(nonatomic, assign) MHGPublisherPrivacyPersonalizationState googlePublisherPrivacyPersonalizationState;

/// Application volume for Google ads. 0.0 (mute) ~ 1.0 (device volume). Default 1.0.
/// Maps to GADMobileAds.applicationVolume
@property(nonatomic, assign) CGFloat googleApplicationVolume;

/// Whether Google ads audio is muted. Default NO.
/// Maps to GADMobileAds.applicationMuted
@property(nonatomic, assign) BOOL googleApplicationMuted;

@end

NS_ASSUME_NONNULL_END

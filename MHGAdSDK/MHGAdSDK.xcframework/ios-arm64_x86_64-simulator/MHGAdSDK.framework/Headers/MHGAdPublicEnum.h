//
//  MHGAdPublicEnum.h
//  MHGAdSDK
//
//  Public enums exposed to publishers. Do not import internal headers here.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Google AdMob Enums

/// Max ad content rating for Google ads.
/// Maps to GADMaxAdContentRating constants.
typedef NS_ENUM(NSInteger, MHGMaxAdContentRating) {
    /// Content suitable for general audiences, including families.
    /// Maps to GADMaxAdContentRatingGeneral
    MHGMaxAdContentRatingGeneral = 0,
    /// Content suitable for most audiences with parental guidance.
    /// Maps to GADMaxAdContentRatingParentalGuidance
    MHGMaxAdContentRatingParentalGuidance,
    /// Content suitable for teen and older audiences.
    /// Maps to GADMaxAdContentRatingTeen
    MHGMaxAdContentRatingTeen,
    /// Content suitable only for mature audiences.
    /// Maps to GADMaxAdContentRatingMatureAudience
    MHGMaxAdContentRatingMatureAudience,
};

/// Publisher privacy personalization state for Google ads.
/// Maps to GADPublisherPrivacyPersonalizationState.
typedef NS_ENUM(NSInteger, MHGPublisherPrivacyPersonalizationState) {
    /// Ad requests receive default publisher privacy treatment.
    MHGPublisherPrivacyPersonalizationStateDefault = 0,
    /// Ad requests receive personalized publisher privacy treatment.
    MHGPublisherPrivacyPersonalizationStateEnabled = 1,
    /// Ad requests receive non-personalized publisher privacy treatment.
    MHGPublisherPrivacyPersonalizationStateDisabled = 2,
};

NS_ASSUME_NONNULL_END

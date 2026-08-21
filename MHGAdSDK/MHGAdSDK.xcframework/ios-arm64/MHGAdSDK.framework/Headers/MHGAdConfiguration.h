//
//  MHGAdConfiguration.h
//  MHGAdSDK
//
//  Created by Jianheng on 2025/3/5.
//

#import <Foundation/Foundation.h>
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

@property(nonatomic, assign) NSInteger mediaFinalEcpm;

/// This interface function:
/// 1. Sets the enableDefaultAudioSessionSetting property of this singleton.
/// ----- -----
/// Call [MHGAdConfiguration sharedConfig].enableDefaultAudioSessionSetting = NO; before SDK loads ads via loadAd.
/// Set the enableDefaultAudioSessionSetting property of this singleton.
///
/// ----- -----
/// This interface is private; if not needed, it can be skipped. For GDT, if not set, it defaults to GDT's own YES.
/// If setting is required, set it before loadAd. During subsequent initialization, the SDK will set this parameter when initializing the GDT SDK.
///
/// ----- Example usage -----
/// 1. Initialize configuration:
/// [MHGAdConfiguration sharedConfig].enableDefaultAudioSessionSetting = NO;
/// 2. Register SDK:
/// [[MHGAdManager sharedManager] registerApp];
/// ----- -----
///
/// Note: When [AD loadAd] is called to request an ad, if the GDT SDK budget is requested, during GDT SDK initialization, [GDTSDKConfig enableDefaultAudioSessionSetting:BOOL] will be executed, passing the pre-set [MHGAdConfiguration sharedConfig].enableDefaultAudioSessionSetting as a parameter.
@property(nonatomic, assign) BOOL enableDefaultAudioSessionSetting;

/// 个性化推荐广告开关。0-开启个性化推荐广告（默认），1-关闭个性化推荐广告。
@property(nonatomic, assign) NSInteger personalizedState;

@end

NS_ASSUME_NONNULL_END

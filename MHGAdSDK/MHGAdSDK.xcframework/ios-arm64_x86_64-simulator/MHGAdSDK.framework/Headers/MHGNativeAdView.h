//
//  MHGNativeAdView.h
//  MHGAdSDK
//
//  Created by Abenx on 2021/9/14.
//

#import <UIKit/UIKit.h>
#import "MHGNativePrepareInfo.h"

NS_ASSUME_NONNULL_BEGIN

@class MHGNativeAdModel;

@protocol MHGNativeAdViewDelegate;

@interface MHGNativeAdView : UIView

@property(nonatomic, weak) id<MHGNativeAdViewDelegate> delegate;

/// bind data
@property(nonatomic, strong) MHGNativeAdModel *nativeAdModel;

@property (nonatomic, assign) BOOL videoPlayFinishClickEnable;

// regist clickable views
- (void)registerClickableViewArray:(NSArray *)registerClickViewArray;

- (void)prepareWithNativePrepareInfo:(MHGNativePrepareInfo *)nativePrepareInfo;

- (nullable UIView *)getMediaView;

@end

@protocol MHGNativeAdViewDelegate <NSObject>

- (void)adViewDidAppear:(MHGNativeAdView *)adView
      withNativeAdModel:(MHGNativeAdModel *)nativeAdModel;

@end

NS_ASSUME_NONNULL_END

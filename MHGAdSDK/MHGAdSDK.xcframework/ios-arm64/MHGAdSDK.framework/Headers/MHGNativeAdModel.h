//
//  MHGNativeAdModel.h
//  MHGAdSDK
//
//  Created by Abenx on 2021/9/14.
//

#import <UIKit/UIKit.h>
#import "MHGNativeAdCouponModel.h"
#import "MHAdExtraInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHGNativeAdModel : NSObject

/// title
@property (nonatomic, readonly, copy) NSString *title;
/// ad description
@property (nonatomic, readonly, copy) NSString *description;
/// call to action
@property (nonatomic, readonly, copy) NSString *actionText;
/// icon url
@property (nonatomic, readonly, copy) NSString *iconURL;
/// main image url
@property (nonatomic, readonly, copy) NSString *imageURL;

/// image || video width
@property (nonatomic, readonly) NSInteger imageWidth;
/// image || video height
@property (nonatomic, readonly) NSInteger imageHeight;

/// isVideo
@property (nonatomic, readonly) BOOL isVideoAd;

/// ecpm
@property (nonatomic, readonly) NSInteger ecpm;

/// coupon info
@property (nonatomic, readonly, strong) MHGNativeAdCouponModel * coupon;

@property (nonatomic, strong, readonly) NSDictionary * extraInfo;

- (void)sendWinNotification:(NSInteger)ecpm;

// send loss
- (void)sendLossNotification:(NSInteger)ecpm;


- (MHAdExtraInfo *)getExtraInfo;

@end

NS_ASSUME_NONNULL_END

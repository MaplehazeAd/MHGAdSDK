//
//  MHGNativeAdCouponModel.h
//  MHGAdSDK
//
//  Created by Jianheng on 2025/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHGNativeAdCouponModel : NSObject

/// Coupon Type
/// 1:Spend-Based Discount Coupon
@property (nonatomic, assign, readonly) NSInteger couponType;

/// Coupon Discount Amount (Unit: Cents)
@property (nonatomic, assign, readonly) NSInteger couponValue;

/// Coupon Minimum Spend Threshold (Unit: Cents)
@property (nonatomic, assign, readonly) NSInteger couponThreshold;

/// Coupon Validity Period (Unit: Minutes)
@property (nonatomic, assign, readonly) NSInteger couponTime;

// 优惠券来源
@property (nonatomic, copy, readonly) NSString * couponSource;

// 优惠券免责声明
@property (nonatomic, copy, readonly) NSString *couponDisclaimer;

// 优惠券描述信息
@property (nonatomic, copy) NSString *couponDescription;

- (instancetype)initWithDictionary:(NSDictionary *)couponDic;

@end

NS_ASSUME_NONNULL_END

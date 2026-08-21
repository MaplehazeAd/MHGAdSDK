//
//  MHGNativeAdConfiguration.h
//  MHGAdSDK
//
//  Created by Jianheng on 2026/1/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MHGNativeAdConfiguration : NSObject

/// placement id
@property (nonatomic, copy) NSString * placementID;

/// video ad auto play in mobile network
@property(nonatomic, assign) BOOL isVideoAutoPlayWithMobileNetwork;

/// ad muted
/// default:YES
@property (nonatomic, assign) BOOL isMuted;



@end

NS_ASSUME_NONNULL_END

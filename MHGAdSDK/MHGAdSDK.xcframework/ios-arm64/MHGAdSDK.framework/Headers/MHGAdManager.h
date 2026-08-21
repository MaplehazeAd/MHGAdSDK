//
//  MHGAdManager.h
//  MHGAdSDK
//
//  Created by Abenx on 2021/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHGAdManager : NSObject

+ (instancetype)sharedManager;

/// SDK regist
- (BOOL)registerApp;


/// SDK version
- (NSString *)version;

@end

NS_ASSUME_NONNULL_END

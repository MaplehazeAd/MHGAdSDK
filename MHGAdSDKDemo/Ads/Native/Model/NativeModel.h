//
//  NativeModel.h
//  MHGAdSDKDemo
//
//  Created by Jianheng on 2025/1/15.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ListNativeCellTypeContent = 0,
    ListNativeCellTypeAd      = 1,
} ListNativeCellType;

NS_ASSUME_NONNULL_BEGIN

@interface NativeModel : NSObject

@property (nonatomic, assign) ListNativeCellType cellType;

@property (nonatomic, copy) NSString * adID;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * des;

@property (nonatomic, copy) NSString * actionText;
@property (nonatomic, copy) NSString * iconURL;

@end

NS_ASSUME_NONNULL_END

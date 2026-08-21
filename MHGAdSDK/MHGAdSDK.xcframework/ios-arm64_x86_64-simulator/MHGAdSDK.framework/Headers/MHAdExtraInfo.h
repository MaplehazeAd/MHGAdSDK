//
//  MHAdExtraInfo.h
//  MHAdSDK
//
//  Created by 郭建恒 on 2026/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHAdExtraInfo : NSObject

/// 广告主包名
@property (nonatomic, readonly, copy) NSString *packageName;
/// 广告主名称
@property (nonatomic, readonly, copy) NSString *appName;
/// 广告标题
@property (nonatomic, readonly, copy) NSString *title;
/// 广告描述
@property (nonatomic, readonly, copy) NSString *des;
/// 素材类型 1-下载类型
@property (nonatomic, readonly) NSInteger downloadType;
/// 广告大图URL链接地址
@property (nonatomic, readonly, copy) NSString *imageURL;
/// 视频地址
@property (nonatomic, readonly, copy) NSString *videoUrl;
/// 素材宽度，单图广告代表大图 imageUrl 宽度
@property (nonatomic, readonly) NSInteger imageWidth;
/// 素材高度，单图广告代表大图 imageUrl 高度
@property (nonatomic, readonly) NSInteger imageHeight;

/// 是不是视频广告
@property (nonatomic, readonly) BOOL isVideoAd;

/// deeplink
@property (nonatomic, readonly, copy) NSString *deepLink;
/// 落地页
@property (nonatomic, readonly, copy) NSString *landpageUrl;
/// 下载链接
@property (nonatomic, readonly, copy) NSString *downloadUrl;

@end

NS_ASSUME_NONNULL_END

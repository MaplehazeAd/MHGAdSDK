//
//  MHGNativePrepareInfo.h
//  MHGAdSDK
//
//  Created by Jianheng on 2026/1/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MHGNativePrepareInfo

@interface MHGNativePrepareInfo : NSObject

/// title
@property(nonatomic, strong) UILabel *titleLabel;
/// call to action
@property(nonatomic, strong) UILabel *ctaLabel;
/// icon image
@property(nonatomic, strong) UIImageView *iconImageView;
/// main image
@property(nonatomic, strong) UIImageView *mainImageView;
/// logo image
@property(nonatomic, strong) UIImageView *logoImageView;
/// text content
@property(nonatomic, strong) UILabel *textLabel;

/// rating
@property(nonatomic, strong) UILabel *ratingLabel;
/// advertiser
@property(nonatomic, strong) UILabel *advertiserLabel;
/// dislike
@property(nonatomic, strong) UIButton *dislikeButton;
/// media
@property(nonatomic, strong) UIView *mediaView;

+ (instancetype)loadPrepareInfo:(void(^)(MHGNativePrepareInfo *config))configBlock;

@end

NS_ASSUME_NONNULL_END

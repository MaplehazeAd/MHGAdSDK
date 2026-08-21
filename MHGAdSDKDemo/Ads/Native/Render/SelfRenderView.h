//
//  SelfRenderView.h
//  MHGAdSDKDemo
//
//  Created by Jianheng on 2026/1/9.
//

#import <UIKit/UIKit.h>
 
#define SelfRenderViewWidth (kScreenW)
#define SelfRenderViewHeight (350)

#define SelfRenderViewMediaViewWidth (kScreenW)
#define SelfRenderViewMediaViewHeight (350 - kNavigationBarHeight - 150)

@interface SelfRenderView : UIView

/// advertiser
@property(nonatomic, strong) UILabel *advertiserLabel;

/// tect content
@property(nonatomic, strong) UILabel *textLabel;

/// title
@property(nonatomic, strong) UILabel *titleLabel;

/// call to actiob
@property(nonatomic, strong) UILabel *ctaLabel;

/// rate
@property(nonatomic, strong) UILabel *ratingLabel;

/// icon image
@property(nonatomic, strong) UIImageView *iconImageView;

/// main image
@property(nonatomic, strong) UIImageView *mainImageView;
 
/// close
@property(nonatomic, strong) UIButton *dislikeButton;

/// media view
@property(nonatomic, strong) UIView *mediaView;

- (void)destory;

@end

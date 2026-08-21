//
//  MHNativeRenderAdDisplayViewController.m
//  MHGAdSDKDemo
//
//  Created by Jianheng on 2026/1/9.
//

#import "MHNativeRenderAdDisplayViewController.h"
#import <MHGAdSDK/MHGAdSDK.h>
#import "UIView+toast.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SelfRenderView.h"

@interface MHNativeRenderAdDisplayViewController ()<MHGNativeAdDelegete>
{
    
}

@property (nonatomic, strong) NSMutableArray * adArray;

// mh sdk native ad container
@property (nonatomic, strong) MHGNativeAdView * nativeAdView;
// demo native ad render view
@property(nonatomic, strong) SelfRenderView *selfRenderView;

// mh sdk native ad
@property (nonatomic, strong) MHGNativeAdConfiguration *configuration;
@property (nonatomic, strong) MHGNativeAd *nativeAd;
//

@end

@implementation MHNativeRenderAdDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareSystemUI];
    [self layoutAllSubViews];
    [self loadAd];
    
    // Do any additional setup after loading the view.
}
#pragma mark - UI
- (void)prepareSystemUI {
    self.title = @"Display";
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonTapped)];
    backButton.accessibilityIdentifier = @"MHNativeViewController_BackButtonItem";
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutAllSubViews {
    self.nativeAdView = [[MHGNativeAdView alloc] init];
    [self.view addSubview:self.nativeAdView];
    [self.nativeAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(400);
    }];

}

#pragma mark - LoadAd
- (void)loadAd {
    // config
    self.configuration = [[MHGNativeAdConfiguration alloc] init];
    self.configuration.placementID = @"210014";
    self.configuration.isMuted = self.isMuted;
    self.configuration.isVideoAutoPlayWithMobileNetwork = YES;
    // native ad
    self.nativeAd = [[MHGNativeAd alloc] initWithConfiguration:self.configuration];
    self.nativeAd.delegate = self;
    self.nativeAd.rootController = self;
    [self.nativeAd loadAd];
}

#pragma mark - MHGNativeAdDelegete

// receive ad success
- (void)nativeAdDidLoad:(MHGNativeAd *)nativeAd
            placementID:(NSString *)placementID
         nativeAdModels:(NSArray<MHGNativeAdModel *> *)nativeAdModels
{
    
    if (nativeAdModels.count <= 0) {
        [self.view makeToast:@"nativeAd no ads!" duration:2.0F position:CSToastPositionTop];
        NSLog(@"nativeAd no ads!");
        return;
    }

    
    [self.view makeToast:@"nativeAd ad loaded!" duration:2.0F position:CSToastPositionBottom];
    
    for (int i = 0 ; i< nativeAdModels.count; i++) {
        MHGNativeAdModel * nativeModel = nativeAdModels[i];
        
        
        NSLog(@"nativeAdDidLoad nativeAdModel pos[%d]: %p", i, nativeModel);
        
        // ----- Coupon Info Start -----
        NSLog(@"coupon info: %@", nativeModel.coupon);
        if (nativeModel.coupon) {
            NSLog(@"coupon type: %ld", nativeModel.coupon.couponType);
            NSLog(@"coupon value: %ld", nativeModel.coupon.couponValue);
            NSLog(@"coupon time: %ld", nativeModel.coupon.couponTime);
            NSLog(@"coupon threshold: %ld", nativeModel.coupon.couponThreshold);
        }
        // ----- Coupon Info End -----
        
        if (nativeModel.isVideoAd) {
            NSLog(@"video width: %ld height: %ld",nativeModel.imageWidth, nativeModel.imageHeight);
        }
        
        // ----- Ecpm Start -----
        NSInteger nativeEcpm = nativeModel.ecpm;
        NSString * ecpmString = [NSString stringWithFormat:@"current ad ecpm[%d]: %ld",i, nativeEcpm];
        [self.view makeToast:ecpmString duration:2.0F position:CSToastPositionCenter];
        // send win or loss
        if (nativeEcpm != -1) {
            [nativeModel sendWinNotification:nativeEcpm];
//            [nativeModel sendLossNotification:nativeEcpm];
        }
        // ----- Ecpm End -----
        
        
        // ad source
        [self.adArray addObject:nativeModel];
        
        // ----- Set Ad Start -----
        // 1. bind nativeAdModel to nativeAdView.
        self.nativeAdView.nativeAdModel = nativeModel;
        // ----- Set Ad Start -----
        
        // ----- Create SelfRenderView Start -----
        // 2. renderview
        self.selfRenderView = [[SelfRenderView alloc] init];
        self.selfRenderView.frame = self.nativeAdView.bounds;
        // update UI
        self.selfRenderView.titleLabel.text = nativeModel.title;
        self.selfRenderView.textLabel.text = nativeModel.description;
        self.selfRenderView.ctaLabel.text = nativeModel.actionText;
        self.selfRenderView.mediaView = [self.nativeAdView getMediaView];
        [self.selfRenderView.iconImageView sd_setImageWithURL:[NSURL URLWithString:nativeModel.iconURL]];
        [self.selfRenderView.mainImageView sd_setImageWithURL:[NSURL URLWithString:nativeModel.imageURL]];
        // ----- Create SelfRenderView End -----
        
        // ----- Bind Data Start -----
        // 3. bind views to sdk
        MHGNativePrepareInfo *info = [MHGNativePrepareInfo loadPrepareInfo:^(MHGNativePrepareInfo * prepareInfo) {
            prepareInfo.textLabel = self.selfRenderView.textLabel;
            prepareInfo.advertiserLabel = self.selfRenderView.advertiserLabel;
            prepareInfo.titleLabel = self.selfRenderView.titleLabel;
            prepareInfo.ratingLabel = self.selfRenderView.ratingLabel;
            prepareInfo.iconImageView = self.selfRenderView.iconImageView;
            prepareInfo.mainImageView = self.selfRenderView.mainImageView;
            prepareInfo.ctaLabel = self.selfRenderView.ctaLabel;
            prepareInfo.dislikeButton = self.selfRenderView.dislikeButton;
            prepareInfo.mediaView = self.selfRenderView.mediaView;
        }];
        [self.nativeAdView prepareWithNativePrepareInfo:info];
        // ----- Bind Data End -----
        
        // ----- Render Start -----
        // 4. render ad
        [self.nativeAd rendererWithRenderView:self.selfRenderView nativeADView:self.nativeAdView];
        // ----- Render End -----
    }
    
    
    
}

// receive ad failed
- (void)nativeAdLoadFailed:(MHGNativeAd *)nativeAd
               placementID:(NSString *)placementID
                 errorCode:(NSInteger)errorCode
              errorMessage:(NSString *)errorMessage
{
    [self.adArray removeAllObjects];
    NSLog(@"SDK ad get failed, error code: %ld... reason: %@", errorCode, errorMessage);
    NSString *toastMessage = [NSString stringWithFormat:@"SDK ad get failed, error code: %ld... reason: %@", errorCode, errorMessage];
    [self.view makeToast:toastMessage duration:2.0F position:CSToastPositionCenter];
}



/// nativeAd did appear
- (void)nativeAdDidAppear:(MHGNativeAd *)nativeAd
              placementID:(NSString *)placementID
                   adView:(MHGNativeAdView *)adView
            nativeAdModel:(MHGNativeAdModel *)nativeAdModel
{
    NSLog(@"nativeAdDidAppear nativeAdModel pos: %p", nativeAdModel);
    [self.view makeToast:@"native ad did appear" duration:2.0F position:CSToastPositionCenter];
    NSLog(@"native ad did appear");
}

/// nativeAd clicked
- (void)nativeAdDidClick:(MHGNativeAd *)nativeAd
             placementID:(NSString *)placementID
                  adView:(MHGNativeAdView *)adView
           nativeAdModel:(MHGNativeAdModel *)nativeAdModel
{
    NSLog(@"nativeAd clicked!");
    NSLog(@"nativeAd clicked! nativeAdModel pos: %p", nativeAdModel);
    [self.view makeToast:@"nativeAd clicked!" duration:2.0F position:CSToastPositionCenter];
}

// nativeAd play start
- (void)nativeAdPlayStart:(MHGNativeAd *)nativeAd
              placementID:(NSString *)placementID
                   adView:(MHGNativeAdView *)adView
            nativeAdModel:(MHGNativeAdModel *)nativeAdModel
{
    NSLog(@"nativeAd play start!");
    NSLog(@"nativeAd play start! nativeAdModel pos: %p", nativeAdModel);
}
/// nativeAd play finished
- (void)nativeAdPlayFinish:(MHGNativeAd *)nativeAd
              placementID:(NSString *)placementID
                   adView:(MHGNativeAdView *)adView
            nativeAdModel:(MHGNativeAdModel *)nativeAdModel
{
    NSLog(@"nativeAd play finished!");
    NSLog(@"nativeAd play finished! nativeAdModel pos: %p", nativeAdModel);
}




@end

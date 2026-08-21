//
//  MHInterstitialViewController.m
//  MHGAdSDKDemo
//
//  Created by Jianheng Guo on 2026/5/13.
//

#import "MHInterstitialViewController.h"
#import "MHCommonTableViewCell.h"
#import "Masonry.h"
#import "MHCommonCellModel.h"
#import <MHGAdSDK/MHGAdSDK.h>
#import "UIView+toast.h"


@interface MHInterstitialViewController ()<UITableViewDelegate, UITableViewDataSource, MHCommonTableViewCellDelegate, MHGInterstitialAdDelegete>

@property (nonatomic, strong) UITableView * interstitialTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

// placement id
@property (nonatomic, copy) NSString * placementID;

@property (nonatomic, strong) MHGInterstitialAd * interstitialAd;

@property (nonatomic, assign) BOOL videoMuted;

@end

@implementation MHInterstitialViewController

// rewardTableView
- (UITableView *)rewardTableView {
    if (!_interstitialTableView) {
        _interstitialTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        //
        _interstitialTableView.backgroundColor = [UIColor clearColor];
        _interstitialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _interstitialTableView.sectionFooterHeight = 0;
        // delegate
        _interstitialTableView.delegate = self;
        _interstitialTableView.dataSource = self;
        
        // regist cell
        [_interstitialTableView registerClass:[MHCommonTableViewCell class] forCellReuseIdentifier:@"MHCommonTableViewCell"];
    }
    return _interstitialTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoMuted = YES;
    self.title = @"Interstitial Ad";
    self.view.backgroundColor = [UIColor whiteColor];
    // back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonTapped)];
    backButton.accessibilityIdentifier = @"MHInterstitialViewController_BackButtonItem";
    self.navigationItem.leftBarButtonItem = backButton;
    [self addTapGestureToDismissKeyboard];
    [self getData];
    
    self.interstitialAd = [[MHGInterstitialAd alloc] initWithPlacementID:self.placementID];
    self.interstitialAd.delegate = self;
    [self layoutAllSubviews];
}

- (void)dealloc
{
    NSLog(@"MHRewardVideoViewController dealloc");
}

- (void)backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

// tap gesture
- (void)addTapGestureToDismissKeyboard {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];

    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}


- (void)handleTap:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];

}

- (void)getData {
    
    self.dataArray = [NSMutableArray array];
    NSMutableArray * configArray = [NSMutableArray array];
    // placement id
    MHCommonCellModel * idModel = [[MHCommonCellModel alloc] init];
    idModel.cellType = MHCommonCellTypeTextField;
    idModel.title = @"Placement id";
    idModel.content = @"210024";
    self.placementID = idModel.content;
    [configArray addObject:idModel];
    
    
    // Mute
    MHCommonCellModel * modeConfigModel = [[MHCommonCellModel alloc] init];
    modeConfigModel.cellType = MHCommonCellTypeSwitch;
    modeConfigModel.title = @"Muted";
    modeConfigModel.isSelect = self.videoMuted;
    [configArray addObject:modeConfigModel];
    [self.dataArray addObject:configArray];
    
    
    MHCommonCellModel * requestModel = [[MHCommonCellModel alloc] init];
    requestModel.cellType = MHCommonCellTypeButton;
    requestModel.title = @"Load Ad";

    NSArray * buttonArray = @[requestModel];
    [self.dataArray addObject:buttonArray];
    
}

- (void)layoutAllSubviews {
    [self.view addSubview:self.rewardTableView];
    [self.rewardTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.width.bottom.equalTo(self.view);
    }];
    
    [self.rewardTableView reloadData];
    
}



#pragma mark ----- UITableViewDelegate && UITableViewDataSource -----
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MHMainTableViewCell";
    MHCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MHCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    MHCommonCellModel * model = self.dataArray[indexPath.section][indexPath.row];
    [cell setCell:model];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray * sectionArray = self.dataArray[section];
    return sectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        return 60;
    }
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Options";
    } else {
        return @" ";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark ----- MHCommonTableViewCellDelegate -----
- (void)mhCommonTableViewCellButtonDidClick:(NSIndexPath *_Nullable)indexPath{
    
    self.interstitialAd = [[MHGInterstitialAd alloc] initWithPlacementID:self.placementID];
    self.interstitialAd.delegate = self;
    self.interstitialAd.videoMuted = self.videoMuted;
    [self.interstitialAd loadAd];
}

- (void)mhCommonTableViewCellCheckBoxDidClick:(NSIndexPath *_Nullable)indexPath isSelect:(BOOL)isSelect{
    
}

- (void)mhCommonTableViewCellSwitchDidClick:(NSIndexPath *_Nullable)indexPath isOpen:(BOOL)isOpen{
    MHCommonCellModel * model = self.dataArray[indexPath.section][indexPath.row];
    NSString * title = model.title;
    if ([title isEqualToString:@"Muted"]) {
        self.videoMuted = isOpen;
        self.interstitialAd.videoMuted = self.videoMuted;
    }
}

- (void)mhCommonTableViewCellTextFieldValueChanged:(NSIndexPath *_Nullable)indexPath text:(NSString *)text {
    self.placementID = text;
}

#pragma mark ----- MHGInterstitialAdDelegete -----

/// Interstitial ad did load
- (void)interstitialAdDidLoad:(MHGInterstitialAd *)interstitialAd
                  placementID:(NSString *_Nullable)placementID
{
    //
    NSLog(@"interstitial video ad did load. interstitialAd pos: %p", interstitialAd);
    NSString * message = @"interstitial video ad did load";
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:2.0F position:CSToastPositionCenter];
    // send win or loss
    if (interstitialAd.ecpm != -1) {
        NSInteger ecpm = interstitialAd.ecpm;
        [self.interstitialAd sendWinNotification:ecpm];
//        [self.rewardedVideoAd sendLossNotification:ecpm];
    }
    
    // display
    [self.interstitialAd presentFromRootViewController:self];
    

    
}
/// Interstitial ad load failed
- (void)interstitialAdLoadFailed:(MHGInterstitialAd * _Nullable)interstitialAd
                     placementID:(NSString *_Nullable)placementID
                       errorCode:(NSInteger)errorCode
                    errorMessage:(NSString *_Nullable)errorMessage
{
    
    NSLog(@"interstitial video ad load failed. errorCode: %ld", errorCode);
    NSString * message = [NSString stringWithFormat:@"interstitial video ad load failed. errorCode: %ld", errorCode];
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:2.0F position:CSToastPositionCenter];
}

/// Interstitial ad did appear
- (void)interstitialAdDidAppear:(MHGInterstitialAd * _Nullable)interstitialAd
                    placementID:(NSString * _Nullable)placementID
{
    NSLog(@"interstitial video ad did appear. interstitialAd pos: %p", interstitialAd);
    
    NSString * message = @"interstitial video ad did appear";
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:2.0F position:CSToastPositionCenter];
}

/// Interstitial ad did disappear
- (void)interstitialAdDidDisappear:(MHGInterstitialAd * _Nullable)interstitialAd
                       placementID:(NSString * _Nullable)placementID
{
    NSLog(@"interstitial video ad did disappear. interstitialAd pos: %p", interstitialAd);
    NSString * message = @"interstitial video ad did disappear";
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:2.0F position:CSToastPositionCenter];
}

/// Splash ad did clicked
- (void)interstitialAdDidClicked:(MHGInterstitialAd *)interstitialAd
                     placementID:(NSString * _Nullable)placementID
{
    NSLog(@"interstitial video ad did clicked. interstitialAd pos: %p", interstitialAd);
    NSString * message = @"interstitial video ad did clicked";
    [[UIApplication sharedApplication].keyWindow makeToast:message duration:2.0F position:CSToastPositionCenter];
}


@end

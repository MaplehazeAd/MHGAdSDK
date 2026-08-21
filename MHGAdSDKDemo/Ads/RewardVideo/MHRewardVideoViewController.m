//
//  MHRewardVideoViewController.m
//  MHGAdSDKDemo
//
//  Created by guojianheng on 2024/11/12.
//

#import "MHRewardVideoViewController.h"
#import "MHCommonTableViewCell.h"
#import "Masonry.h"
#import "MHCommonCellModel.h"
#import <MHGAdSDK/MHGAdSDK.h>
#import "UIView+toast.h"


@interface MHRewardVideoViewController ()<UITableViewDelegate, UITableViewDataSource, MHCommonTableViewCellDelegate, MHGRewardedVideoAdDelegete>

//
@property (nonatomic, strong) UITableView * rewardTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

// placement id
@property (nonatomic, copy) NSString * placementID;

@property (nonatomic, strong) MHGRewardedVideoAd *rewardedVideoAd;

@property (nonatomic, assign) BOOL isMuted;
@property (nonatomic, assign) BOOL enableAudio;
@end

@implementation MHRewardVideoViewController

// rewardTableView
- (UITableView *)rewardTableView {
    if (!_rewardTableView) {
        _rewardTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        //
        _rewardTableView.backgroundColor = [UIColor clearColor];
        _rewardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rewardTableView.sectionFooterHeight = 0;
        // delegate
        _rewardTableView.delegate = self;
        _rewardTableView.dataSource = self;
        
        // regist cell
        [_rewardTableView registerClass:[MHCommonTableViewCell class] forCellReuseIdentifier:@"MHCommonTableViewCell"];
    }
    return _rewardTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isMuted = YES; 
    self.enableAudio = YES;
    self.title = @"Rewarded Video Ad";
    self.view.backgroundColor = [UIColor whiteColor];
    // back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonTapped)];
    backButton.accessibilityIdentifier = @"MHRewardVideoViewController_BackButtonItem";
    self.navigationItem.leftBarButtonItem = backButton;
    [self addTapGestureToDismissKeyboard];
    [self getData];
    
    self.rewardedVideoAd = [[MHGRewardedVideoAd alloc] initWithPlacementID:self.placementID];
    self.rewardedVideoAd.delegate = self;
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
    idModel.content = @"210013";
    self.placementID = idModel.content;
    [configArray addObject:idModel];
    
    
    // Mute
    MHCommonCellModel * modeConfigModel = [[MHCommonCellModel alloc] init];
    modeConfigModel.cellType = MHCommonCellTypeSwitch;
    modeConfigModel.title = @"Muted";
    modeConfigModel.isSelect = self.isMuted;
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
    
    self.rewardedVideoAd = [[MHGRewardedVideoAd alloc] initWithPlacementID:self.placementID];
    self.rewardedVideoAd.delegate = self;
    self.rewardedVideoAd.isMuted = self.isMuted;
    [self.rewardedVideoAd loadAd];
}

- (void)mhCommonTableViewCellCheckBoxDidClick:(NSIndexPath *_Nullable)indexPath isSelect:(BOOL)isSelect{
    
}

- (void)mhCommonTableViewCellSwitchDidClick:(NSIndexPath *_Nullable)indexPath isOpen:(BOOL)isOpen{
    MHCommonCellModel * model = self.dataArray[indexPath.section][indexPath.row];
    NSString * title = model.title;
    if ([title isEqualToString:@"Muted"]) {
        self.isMuted = isOpen;
        self.rewardedVideoAd.isMuted = self.isMuted;
    } else {
        self.enableAudio = isOpen;
        [MHGAdConfiguration sharedConfig].enableDefaultAudioSessionSetting = self.enableAudio;
    }
    
}

- (void)mhCommonTableViewCellTextFieldValueChanged:(NSIndexPath *_Nullable)indexPath text:(NSString *)text {
    self.placementID = text;
}

#pragma mark ----- MHRewardedVideoAdDelegete -----
/// rewarded video ad did load.
- (void)rewardedVideoAdVideoDidLoad:(MHGRewardedVideoAd *)rewardedVideoAd
                        placementID:(NSString *)placementID
{
    NSLog(@"rewarded video ad did load. rewardedVideoAd pos: %p", rewardedVideoAd);
    // send win or loss
    if (rewardedVideoAd.ecpm != -1) {
        NSInteger ecpm = rewardedVideoAd.ecpm;
        [self.rewardedVideoAd sendWinNotification:ecpm];
//        [self.rewardedVideoAd sendLossNotification:ecpm];
    }
    
    // display
    BOOL isShow = [self.rewardedVideoAd showAdFromRootViewController:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger ecpm = rewardedVideoAd.ecpm;
        NSString * ecpmString = [NSString stringWithFormat:@"current ad ecpm: %ld", ecpm];
        [[UIApplication sharedApplication].keyWindow makeToast:ecpmString duration:2.0F position:CSToastPositionCenter];
    });
}

// load failed.
- (void)rewardedVideoAdVideoLoadFailed:(MHGRewardedVideoAd *)rewardedVideoAd
                           placementID:(NSString *)placementID
                             errorCode:(NSInteger)errorCode
                          errorMessage:(NSString *)errorMessage
{
    NSLog(@"%@", errorMessage);
    [self.view makeToast:errorMessage duration:2.0F position:CSToastPositionCenter];
}

/// rewarded video ad will appear.
- (void)rewardedVideoAdWillAppear:(MHGRewardedVideoAd *)rewardedVideoAd
                      placementID:(NSString *)placementID
{
    NSLog(@"rewarded video ad will appear");
}

/// rewarded video ad did appear.
- (void)rewardedVideoAdDidAppear:(MHGRewardedVideoAd *)rewardedVideoAd
                     placementID:(NSString *)placementID
{
    NSLog(@"rewarded video ad did appear. rewardedVideoAd pos: %p", rewardedVideoAd);
    [self.view makeToast:@"rewarded video ad did appear." duration:2.0F position:CSToastPositionTop];
}

/// rewarded video ad did clicked.
- (void)rewardedVideoAdDidDisappear:(MHGRewardedVideoAd *)rewardedVideoAd
                        placementID:(NSString *)placementID
{
    NSLog(@"rewarded video ad did clicked.");
    [self.view makeToast:@"rewarded video ad did disappear." duration:2.0F position:CSToastPositionTop];
}

/// rewarded video ad did clicked.
- (void)rewardedVideoAdDidClicked:(MHGRewardedVideoAd *)rewardedVideoAd
                      placementID:(NSString *)placementID
{
    NSLog(@"rewarded video ad did clicked.");
    [[UIApplication sharedApplication].keyWindow makeToast:@"rewarded video ad did clicked." duration:2.0F position:CSToastPositionCenter];
}

/// rewarded video ad did rewarded.
- (void)rewardedVideoAdVideoDidRewarded:(MHGRewardedVideoAd *)rewardedVideoAd
                                 result:(BOOL)success
                            placementID:(NSString *)placementID
{
    NSLog(@"rewarded video ad did rewarded. flag: %d", success);
    [self.view makeToast:@"rewarded video ad did rewarded." duration:2.0F position:CSToastPositionTop];
}

/// rewarded video ad did finished.
- (void)rewardedVideoAdVideoDidFinished:(MHGRewardedVideoAd *)rewardedVideoAd
                            placementID:(NSString *)placementID
{
    NSLog(@"rewarded video ad did finished.");
    [[UIApplication sharedApplication].keyWindow makeToast:@"rewarded video ad did finished." duration:2.0F position:CSToastPositionTop];
}


@end

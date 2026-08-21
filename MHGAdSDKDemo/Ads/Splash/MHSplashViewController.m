//
//  MHNewNativeViewController.m
//  MHGAdSDKDemo
//
//  Created by Jianheng on 2024/11/21.
//

#import "MHSplashViewController.h"
#import <MHGAdSDK/MHGAdSDK.h>
#import "Masonry.h"
#import "MHCommonTableViewCell.h"
#import "UIView+toast.h"

@interface MHSplashViewController ()<UITableViewDelegate, UITableViewDataSource, MHCommonTableViewCellDelegate, MHGSplashAdDelegete>

//
@property (nonatomic, strong) UITableView* splashTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, copy) NSString * adID;

@property (nonatomic, strong) MHGSplashAd *splashAd;

@end

@implementation MHSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Splash Ad";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonTapped)];
    backButton.accessibilityIdentifier = @"MHSplashViewController_BackButtonItem";
    self.navigationItem.leftBarButtonItem = backButton;
    // Do any additional setup after loading the view.
    [self addTapGestureToDismissKeyboard];
    
    [self getData];
    [self layoutAllSubviews];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)layoutAllSubviews {
        
    [self.view addSubview:self.splashTableView];
    [self.splashTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.width.height.equalTo(self.view);
    }];
    
    [self.splashTableView reloadData];
    
}

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
    
    MHCommonCellModel * idModel = [[MHCommonCellModel alloc] init];
    idModel.cellType = MHCommonCellTypeTextField;
    idModel.title = @"Placement Id";
    idModel.content = @"210012";
    self.adID = idModel.content;
    [configArray addObject:idModel];
    

    [self.dataArray addObject:configArray];
    
    if ([MHGAdConfiguration sharedConfig].allowShake == YES) {
        MHCommonCellModel * shakeConfigModel = [[MHCommonCellModel alloc] init];
        shakeConfigModel.cellType = MHCommonCellTypeSwitch;
        shakeConfigModel.title = @"Shake";
        shakeConfigModel.isSelect = [MHGAdConfiguration sharedConfig].allowShake;
        [configArray addObject:shakeConfigModel];
    }
    
    MHCommonCellModel * requestModel = [[MHCommonCellModel alloc] init];
    requestModel.cellType = MHCommonCellTypeButton;
    requestModel.title = @"Load and display ad";
    NSArray * buttonArray = @[requestModel];
    [self.dataArray addObject:buttonArray];
    
}

// Lazy load mainTableView
- (UITableView *)splashTableView {
    if (!_splashTableView) {
        _splashTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _splashTableView.backgroundColor = [UIColor clearColor];
        _splashTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _splashTableView.sectionFooterHeight = 0;
        // delegate
        _splashTableView.delegate = self;
        _splashTableView.dataSource = self;
        
        // register cell
        [_splashTableView registerClass:[MHCommonTableViewCell class] forCellReuseIdentifier:@"MHCommonTableViewCell"];
    }
    return _splashTableView;
}

- (UIImage *)getAppIcon {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *iconsDictionary = infoDictionary[@"CFBundleIcons"];
    NSDictionary *primaryIconsDictionary = iconsDictionary[@"CFBundlePrimaryIcon"];
    NSArray *iconFiles = primaryIconsDictionary[@"CFBundleIconFiles"];
    NSString *iconName = [iconFiles lastObject];
    return [UIImage imageNamed:iconName];
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

#pragma mark - MHCommonTableViewCellDelegate
- (void)mhCommonTableViewCellButtonDidClick:(NSIndexPath * _Nullable)indexPath {
    // load ad
    self.splashAd = [[MHGSplashAd alloc] initWithPlacementID:self.adID];
    self.splashAd.delegate = self;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat adHeighr = [UIScreen mainScreen].bounds.size.height - 120;
    self.splashAd.viewSize = CGSizeMake(viewWidth, adHeighr);
    self.splashAd.rootController = self;
    [self.splashAd loadAd];
}

- (void)mhCommonTableViewCellCheckBoxDidClick:(NSIndexPath * _Nullable)indexPath isSelect:(BOOL)isSelect {
    
}

- (void)mhCommonTableViewCellSwitchDidClick:(NSIndexPath * _Nullable)indexPath isOpen:(BOOL)isOpen {
    
}

#pragma mark - MHGSplashAdDelegete
- (void)mhCommonTableViewCellTextFieldValueChanged:(NSIndexPath *_Nullable)indexPath text:(NSString *)text {
    self.adID = text;
}

#pragma mark - MHSplashAdDelegete
- (void)splashAdDidLoad:(MHGSplashAd *)splashAd placementID:(NSString *)placementID
{
    NSLog(@"SplashViewController splashAdDidLoad");
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[self getAppIcon]];
    logoImageView.frame = CGRectMake(0, 0, 80, 80);
    logoImageView.center = bottomView.center;
    [bottomView addSubview:logoImageView];
    
    if (splashAd.ecpm != -1) {
        [self.splashAd sendWinNotification:splashAd.ecpm];
    }
    
    // show
    BOOL isShow = [self.splashAd showInWindow:[UIApplication sharedApplication].keyWindow
                 withBottomView: bottomView
                       skipView: nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger ecpm = splashAd.ecpm;
        NSString * ecpmString = [NSString stringWithFormat:@"current ecpm: %ld", ecpm];
        [[UIApplication sharedApplication].keyWindow makeToast:ecpmString duration:2.0F position:CSToastPositionCenter];
    });
    
}

- (void)splashAdLoadFailed:(MHGSplashAd *)splashAd errorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage
{
    NSString * ERROR = [NSString stringWithFormat:@"code: %ld - %@",errorCode, errorMessage];
    [self.view makeToast:ERROR duration:2.0F position:CSToastPositionCenter];
}


- (void)splashAdDidAppear:(MHGSplashAd * _Nullable)splashAd placementID:(NSString * _Nullable)placementID { 
    NSLog(@"SplashViewController splashAdDidAppear");
}

- (void)splashAdDidClicked:(MHGSplashAd * _Nullable)splashAd placementID:(NSString * _Nullable)placementID { 
    NSLog(@"SplashViewController splashAdDidClicked");
}


- (void)splashAdDidDisappear:(MHGSplashAd * _Nullable)splashAd placementID:(NSString * _Nullable)placementID { 
    NSLog(@"SplashViewController splashAdDidDisappear");


}


/// Splash ad enters full-screen ad
- (void)splashAdDidPresentFullScreen:(MHGSplashAd * _Nullable)splashAd
                         placementID:(NSString *_Nullable)placementID
{
    NSLog(@"SplashViewController splash ad opened ad detail H5");
    
    [self.view makeToast:@"SplashViewController splash ad opened ad detail H5" duration:5.0F position:CSToastPositionCenter];
}

/// Splash ad dismisses full-screen ad
- (void)splashAdDidDismissFullScreen:(MHGSplashAd * _Nullable)splashAd
                         placementID:(NSString *_Nullable)placementID
{
    NSLog(@"SplashViewController splash ad dismissed ad detail H5");
    
    [self.view makeToast:@"SplashViewController splash ad dismissed ad detail H5" duration:5.0F position:CSToastPositionCenter];
}


@end

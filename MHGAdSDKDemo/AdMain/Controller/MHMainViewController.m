//
//  MHMainViewController.m
//  MHGAdSDKDemo
//
//  Created by guojianheng on 2024/11/11.
//

#import "MHMainViewController.h"
#import "MHMainTableViewCell.h"
#import "Masonry.h"
#import "MHSplashViewController.h"
#import "MHRewardVideoViewController.h"
#import "MHNativeViewController.h"
#import "MHInterstitialViewController.h"
#import "MHSettingViewController.h"

@interface MHMainViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView * mainTableView;

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation MHMainViewController

// Lazy load mainTableView
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [_mainTableView registerClass:[MHMainTableViewCell class] forCellReuseIdentifier:@"MHMainTableViewCell"];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MHGAdSDK Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"Setting"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(settingButtonTapped)];
    settingButton.accessibilityIdentifier = @"MHNativeListViewController_SettingButtonItem";
    self.navigationItem.rightBarButtonItem = settingButton;
    
    [self getData];
    [self layoutAllSubviews];
}

- (void)settingButtonTapped {
    MHSettingViewController * settingVC = [[MHSettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

- (void)getData {
    self.dataArray = @[@"Splash Ad", @"Native Ad", @"Rewarded Video Ad", @"Interstitial Ad"];
    
}

- (void)layoutAllSubviews {
    [self.view addSubview:self.mainTableView];
    self.mainTableView.accessibilityIdentifier = @"MHMainViewController_MainTableView";
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.width.bottom.equalTo(self.view);
    }];
    
    [self.mainTableView reloadData];
    
}



#pragma mark ----- UITableViewDelegate && UITableViewDataSource -----
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MHMainTableViewCell";
    MHMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MHMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    NSString * content = self.dataArray[indexPath.row];
    [cell setCell:content];
    NSInteger row = indexPath.row;
    cell.accessibilityIdentifier = [NSString stringWithFormat:@"MHMainViewController_MainTableViewCell_%ld",row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            MHSplashViewController * splashVC = [[MHSplashViewController alloc] init];
            [self.navigationController pushViewController:splashVC animated:true];
            break;
        }
        case 1:
        {
            MHNativeViewController * nativeVC = [[MHNativeViewController alloc] init];
            [self.navigationController pushViewController:nativeVC animated:true];
            break;
        }
        case 2:
        {
            MHRewardVideoViewController * rewardedVC = [[MHRewardVideoViewController alloc] init];
            [self.navigationController pushViewController:rewardedVC animated:true];
            break;
        }
            
        case 3:
        {
            MHInterstitialViewController * interstitialVC = [[MHInterstitialViewController alloc] init];
            [self.navigationController pushViewController:interstitialVC animated:true];
            break;
        }
            
        default:
            break;
    }
    
}



@end

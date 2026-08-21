//
//  MHNativeViewController2.m
//  MHGAdSDKDemo
//
//  Created by Jianheng on 2026/1/9.
//

#import "MHNativeViewController.h"
#import "Masonry.h"
#import "MHCommonTableViewCell.h"
#import "MHNativeRenderAdDisplayViewController.h"
#import <MHGAdSDK/MHGAdSDK.h>

@interface MHNativeViewController ()<UITableViewDelegate, UITableViewDataSource, MHCommonTableViewCellDelegate>

//
@property (nonatomic, strong) UITableView* nativeTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;


@property (nonatomic, copy) NSString * adID;
@property (nonatomic, assign) NSInteger adCount;

@property (nonatomic, assign) BOOL isMuted;
@property (nonatomic, assign) BOOL isAutoPlayMobileNetwork;


@end

@implementation MHNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NativeRenderAd";
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonTapped)];
    backButton.accessibilityIdentifier = @"MHNativeViewController_BackButtonItem";
    self.navigationItem.leftBarButtonItem = backButton;
    

    self.isMuted = YES;
    self.isAutoPlayMobileNetwork = YES;
    self.adCount = 1;

    [self addTapGestureToDismissKeyboard];
    [self getData];
    
    [self layoutAllSubviews];
}

- (void)backButtonTapped{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)layoutAllSubviews {
    
    [self.view addSubview:self.nativeTableView];
    [self.nativeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.width.height.equalTo(self.view);
    }];
    
    [self.nativeTableView reloadData];
    
}

- (void)addTapGestureToDismissKeyboard {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    // Set cancelsTouchesInView to NO to ensure it doesn't affect touch events of other controls
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

- (void)getData {
    self.dataArray = [NSMutableArray array];
    
    MHCommonCellModel * idModel = [[MHCommonCellModel alloc] init];
    idModel.cellType = MHCommonCellTypeTextField;
    idModel.title = @"placement id";
//    idModel.content = @"61903";
    idModel.content = @"210014";
    self.adID = idModel.content;
    [self.dataArray addObject:idModel];
    
    // Muted
    MHCommonCellModel * audioConfigModel = [[MHCommonCellModel alloc] init];
    audioConfigModel.cellType = MHCommonCellTypeSwitch;
    audioConfigModel.title = @"Muted";
    audioConfigModel.isSelect = self.isMuted;
    [self.dataArray addObject:audioConfigModel];
    
    
    MHCommonCellModel * autoPlayConfigModel = [[MHCommonCellModel alloc] init];
    autoPlayConfigModel.cellType = MHCommonCellTypeSwitch;
    autoPlayConfigModel.title = @"Auto play in moblie network";
    autoPlayConfigModel.isSelect = self.isAutoPlayMobileNetwork;
    [self.dataArray addObject:autoPlayConfigModel];
    
    
    MHCommonCellModel * requestModel = [[MHCommonCellModel alloc] init];
    requestModel.cellType = MHCommonCellTypeButton;
    requestModel.title = @"Load and display ad";
    [self.dataArray addObject:requestModel];
    

}


- (void)removeCloseAdData {
    [self.dataArray removeLastObject];
}


// Lazy load mainTableView
- (UITableView *)nativeTableView {
    if (!_nativeTableView) {
        _nativeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        // Background color
        _nativeTableView.backgroundColor = [UIColor clearColor];
        _nativeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _nativeTableView.sectionFooterHeight = 0;
        // Delegate
        _nativeTableView.delegate = self;
        _nativeTableView.dataSource = self;
        // Register cell
        [_nativeTableView registerClass:[MHCommonTableViewCell class] forCellReuseIdentifier:@"MHCommonTableViewCell"];
    }
    return _nativeTableView;
}

- (void)dealloc {
    NSLog(@"NativeVC dealloc");
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
    
    MHCommonCellModel * model = self.dataArray[indexPath.row];
    [cell setCell:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // Only options
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 500;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Section";
}
#pragma mark - MHCommonTableViewCellDelegate
- (void)mhCommonTableViewCellButtonDidClick:(NSIndexPath * _Nullable)indexPath {
    MHCommonCellModel * model = self.dataArray[indexPath.row];
    NSString * title = model.title;
    if ([title isEqualToString:@"Load and display ad"]) {
        
        MHNativeRenderAdDisplayViewController * displayVC = [[MHNativeRenderAdDisplayViewController alloc] init];
        displayVC.isMuted = self.isMuted;
        [self.navigationController pushViewController:displayVC animated:YES];
        
    }
   
}

- (void)mhCommonTableViewCellCheckBoxDidClick:(NSIndexPath * _Nullable)indexPath isSelect:(BOOL)isSelect {
    
}

- (void)mhCommonTableViewCellSwitchDidClick:(NSIndexPath * _Nullable)indexPath isOpen:(BOOL)isOpen {
    MHCommonCellModel * model = self.dataArray[indexPath.row];
    NSString * title = model.title;
    if ([title isEqualToString:@"Muted"]) {
        self.isMuted = isOpen;
        for (MHCommonCellModel *item in self.dataArray) {
            if ([item.title isEqualToString:@"Muted"]) {
                item.isSelect = isOpen;
                break;
            }
        }
        
    } else if ([title isEqualToString:@"Auto play in moblie network"]) {
        self.isAutoPlayMobileNetwork = isOpen;
        for (MHCommonCellModel *item in self.dataArray) {
            if ([item.title isEqualToString:@"Auto play in moblie network"]) {
                item.isSelect = isOpen;
                break;
            }
        }
    }
    
    // Refresh UI
    [self.nativeTableView reloadData];
}




@end

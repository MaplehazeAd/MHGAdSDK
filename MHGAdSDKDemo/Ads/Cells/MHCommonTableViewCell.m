//
//  MHCommonTableViewCell.m
//  MHGAdSDKDemo
//
//  Created by guojianheng on 2024/11/12.
//

#import "MHCommonTableViewCell.h"
#import "Masonry.h"

@interface MHCommonTableViewCell ()<UITextFieldDelegate>

//
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *valueSwitch;
@property (nonatomic, strong) UIButton *checkBoxButton;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *clickButton;

@end

@implementation MHCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self layoutAllSubViews];
    }
    
    return self;
}

- (void)layoutAllSubViews {
    
    self.titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leading.equalTo(self.contentView.mas_leading).offset(30);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    self.valueSwitch = [[UISwitch alloc] init];
    [self.valueSwitch addTarget:self action:@selector(valueSwitchDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.valueSwitch];
    [self.valueSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-16);
        make.width.mas_equalTo(64);
        make.height.equalTo(self.titleLabel);
    }];
    
    self.checkBoxButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.checkBoxButton addTarget:self action:@selector(checkBoxDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.checkBoxButton.backgroundColor = [UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1];
    [self.contentView addSubview:self.checkBoxButton];
    [self.checkBoxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-30);
        make.width.height.mas_equalTo(24);
    }];
    
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.placeholder = @"placeholder";
    [self.inputTextField addTarget:self
                            action:@selector(textFieldDidEditingChange:)
                  forControlEvents:UIControlEventEditingChanged];
    self.inputTextField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-30);
        make.width.mas_equalTo(100);
        make.height.equalTo(self.titleLabel);
    }];
    
    self.clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.clickButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.clickButton.backgroundColor = [UIColor colorWithRed:226/255.0 green:142/255.0 blue:100/255.0 alpha:1];
    self.clickButton.layer.cornerRadius = 10;
    self.clickButton.layer.masksToBounds = YES;
    [self.contentView addSubview:self.clickButton];
    self.clickButton.accessibilityIdentifier = @"MHCommonTableViewCell_ShowButton";
    [self.clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-30);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)valueSwitchDidChange:(UISwitch * )sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mhCommonTableViewCellSwitchDidClick:isOpen:)]){
        // callback
        [self.delegate mhCommonTableViewCellSwitchDidClick:self.indexPath isOpen:sender.isOn];
    }
}

- (void)checkBoxDidClick:(UIButton * )button {
    self.model.isSelect = !self.model.isSelect;
    //
    if (self.model.isSelect == YES) {
        self.checkBoxButton.backgroundColor = [UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1];
    } else {
        self.checkBoxButton.backgroundColor = [UIColor redColor];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(mhCommonTableViewCellCheckBoxDidClick:isSelect:)]){
        [self.delegate mhCommonTableViewCellCheckBoxDidClick:self.indexPath isSelect:self.model.isSelect];
    }
}

- (void)buttonDidClick:(UIButton * )button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mhCommonTableViewCellButtonDidClick:)]){
        [self.delegate mhCommonTableViewCellButtonDidClick:self.indexPath];
    }
}

- (void)setCell:(MHCommonCellModel *)model {
    self.model = model;
    [self updateUI:model];
    
    self.titleLabel.text = model.title;
    self.valueSwitch.on = model.isSelect;
    
    self.inputTextField.text = model.content;
    if (model.isSelect == YES) {
        self.checkBoxButton.backgroundColor = [UIColor colorWithRed:76/255.0 green:175/255.0 blue:80/255.0 alpha:1];
    } else {
        self.checkBoxButton.backgroundColor = [UIColor redColor];
    }
    [self.clickButton setTitle:model.title forState:UIControlStateNormal];
}

- (void)updateUI:(MHCommonCellModel *)model {
    MHCommonCellType cellType = model.cellType;
    switch (cellType) {
        case MHCommonCellTypeSwitch:
        {
            self.checkBoxButton.hidden = YES;
            self.inputTextField.hidden = YES;
            self.clickButton.hidden = YES;
            
            self.titleLabel.hidden = NO;
            self.valueSwitch.hidden = NO;
            
        }
            break;
        case MHCommonCellTypeCheckBox:
        {
            self.valueSwitch.hidden = YES;
            self.inputTextField.hidden = YES;
            self.clickButton.hidden = YES;
            
            self.titleLabel.hidden = NO;
            self.checkBoxButton.hidden = NO;
        }
            break;
        case MHCommonCellTypeTextField:
        {
            self.valueSwitch.hidden = YES;
            self.checkBoxButton.hidden = YES;
            self.clickButton.hidden = YES;
            
            self.titleLabel.hidden = NO;
            self.inputTextField.hidden = NO;
        }
            break;
        case MHCommonCellTypeButton:
        {
            self.valueSwitch.hidden = YES;
            self.checkBoxButton.hidden = YES;
            self.titleLabel.hidden = YES;
            self.inputTextField.hidden = YES;
            
            self.clickButton.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)textFieldDidEditingChange:(UITextField *)textField {
    // Use textField.text directly as the latest complete string
    NSString *fullText = textField.text;
    NSLog(@"Text changed: %@", fullText);
    // You can perform your business logic here, such as search, button state updates, etc.
    if (self.delegate && [self.delegate respondsToSelector:@selector(mhCommonTableViewCellTextFieldValueChanged:text:)]) {
        [self.delegate mhCommonTableViewCellTextFieldValueChanged:self.indexPath text:fullText];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

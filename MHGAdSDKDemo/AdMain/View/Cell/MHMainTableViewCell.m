//
//  MHMainTableViewCell.m
//  MHGAdSDKDemo
//
//  Created by guojianheng on 2024/11/11.
//

#import "MHMainTableViewCell.h"
#import "Masonry.h"

@interface MHMainTableViewCell ()

@end

@implementation MHMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self layoutAllSubViews];
    }
    
    return self;
}

// Layout UI elements
- (void)layoutAllSubViews {
    
    self.contentLabel = [[UILabel alloc] init];
    
    self.contentLabel.text = @"1111";
    [self.contentView addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leading.equalTo(self.contentView.mas_leading).offset(16);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(40);
    }];
}

- (void)setCell:(NSString *)content {
    self.contentLabel.text = content;
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

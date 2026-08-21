//
//  MHMainTableViewCell.h
//  MHGAdSDKDemo
//
//  Created by guojianheng on 2024/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHMainTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


- (void)setCell:(NSString *)text ;

@end

NS_ASSUME_NONNULL_END

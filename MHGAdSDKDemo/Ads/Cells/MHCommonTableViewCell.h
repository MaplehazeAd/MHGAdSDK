//
//  MHCommonTableViewCell.h
//  MHGAdSDKDemo
//
//  Created by guojianheng on 2024/11/12.
//

#import <UIKit/UIKit.h>
#import "MHCommonCellModel.h"

@protocol MHCommonTableViewCellDelegate <NSObject>

- (void)mhCommonTableViewCellButtonDidClick:(NSIndexPath *_Nullable)indexPath;

- (void)mhCommonTableViewCellCheckBoxDidClick:(NSIndexPath *_Nullable)indexPath isSelect:(BOOL)isSelect;

- (void)mhCommonTableViewCellSwitchDidClick:(NSIndexPath *_Nullable)indexPath isOpen:(BOOL)isOpen;

- (void)mhCommonTableViewCellTextFieldValueChanged:(NSIndexPath *_Nullable)indexPath text:(NSString *)text;

@end

NS_ASSUME_NONNULL_BEGIN

@class MHCommonCellModel;
@interface MHCommonTableViewCell : UITableViewCell



@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, strong) MHCommonCellModel * model;
@property (nonatomic, weak)id<MHCommonTableViewCellDelegate> delegate;


- (void)setCell:(MHCommonCellModel *)model ;

@end

NS_ASSUME_NONNULL_END

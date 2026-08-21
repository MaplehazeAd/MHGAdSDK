//
//  MHCommonCellModel.h
//  MHGAdSDKDemo
//
//  Created by guojianheng on 2024/11/12.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MHCommonCellTypeSwitch       = 0,
    MHCommonCellTypeCheckBox     = 1,
    MHCommonCellTypeTextField    = 2,
    MHCommonCellTypeButton       = 3,
} MHCommonCellType;

NS_ASSUME_NONNULL_BEGIN

@interface MHCommonCellModel : NSObject

@property (nonatomic, assign)MHCommonCellType cellType;

@property (nonatomic, copy)NSString * title;

@property (nonatomic, copy)NSString * content;

@property (nonatomic, assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END

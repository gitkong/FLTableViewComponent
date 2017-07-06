//
//  HYBaseComponent.h
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "FLTableComponentProtocol.h"

typedef NS_ENUM(NSUInteger, FLComponentRemoveType) {
    FLComponentRemoveTypeAll,
    FLComponentRemoveTypeLast
};

@interface FLBaseComponent : NSObject<FLBaseComponentProtocol>

@property (nonatomic, assign) NSInteger section;

@end

//
//  HYBaseComponentProtocol.h
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FLBaseComponentProtocol <NSObject>

@required
- (NSString *)cellIdentifier;

- (NSString *)headerIdentifier;

- (NSString *)footerIdentifier;

- (void)registComponent;

@end

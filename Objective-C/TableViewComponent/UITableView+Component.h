//
//  UITableView+Component.h
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLTableViewHandler;

@interface UITableView (Component)

@property (nonatomic, weak) FLTableViewHandler *handler;

- (void)registerNibClass:(Class)nibClass forCellReuseIdentifier:(NSString *)identifier;

- (void)registerNibClass:(Class)nibClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;

@end

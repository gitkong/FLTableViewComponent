//
//  HYTableComponent.h
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "FLBaseComponent.h"
#import "UITableView+Component.h"

#define KHYDefaultCellHeight 44

@interface FLTableComponent : FLBaseComponent<FLTableComponentProtocol>

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, copy, readonly) NSString *componentIdentifier;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (instancetype)initWithTableView:(UITableView *)tableView identifier:(NSString *)identifier ;

@end

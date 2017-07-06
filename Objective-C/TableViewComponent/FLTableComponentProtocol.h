//
//  HYTableComponentProtocol.h
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "FLBaseComponentProtocol.h"

@protocol FLTableComponentProtocol <FLBaseComponentProtocol>

@required

- (NSInteger)numberOfCells;

- (UITableViewCell *)cellForRow:(NSInteger)row;

@optional

- (void)tableViewWillDisplayCell:(UITableViewCell *)cell atRow:(NSInteger)row;

- (void)tableViewWillDisplayHeader:(UITableViewHeaderFooterView *)headerView atSection:(NSInteger)section;

- (void)tableViewWillDisplayFooter:(UITableViewHeaderFooterView *)headerView atSection:(NSInteger)section;

- (UITableViewHeaderFooterView *)headerViewAtSection:(NSInteger)section;

- (UITableViewHeaderFooterView *)footerViewAtSection:(NSInteger)section;

- (CGFloat)heightForCellAtRow:(NSInteger)row;

- (CGFloat)heightForHeader;

- (CGFloat)heightForFooter;

@end

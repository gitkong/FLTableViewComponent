//
//  HYTableComponentController.h
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLTableComponent.h"
#import "FLTableViewHandler.h"

@interface FLTableComponentController : UIViewController

@property (nonatomic, strong, readonly) FLTableViewHandler *handler;

@property (nonatomic, strong) NSArray<FLTableComponent *> *components;

@property (nonatomic, strong, readonly) UITableView *tableView;

- (CGRect)customTableViewBounds;

- (UITableViewStyle)customTableViewStyle;

@end

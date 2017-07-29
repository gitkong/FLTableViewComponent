//
//  HYTableComponentController.m
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "FLTableComponentController.h"

@interface FLTableComponentController ()

@property (nonatomic, strong) FLTableViewHandler *handler;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FLTableComponentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark Public Method

- (CGRect)customTableViewBounds {
    return self.view.bounds;
}

- (UITableViewStyle)customTableViewStyle {
    return UITableViewStylePlain;
}

#pragma mark Setter & Getter

- (void)setComponents:(NSArray<FLTableComponent *> *)components {
    _components = components;
    self.handler.components = components;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[self customTableViewBounds] style:[self customTableViewStyle]];
    }
    return _tableView;
}

- (FLTableViewHandler *)handler {
    if (_handler == nil) {
        _handler = [[FLTableViewHandler alloc] init];
    }
    return _handler;
}

@end

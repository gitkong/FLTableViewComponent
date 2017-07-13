//
//  HYTableComponent.m
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "FLTableComponent.h"

@interface FLTableComponent ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *componentIdentifier;

@property (nonatomic, assign) BOOL isCustomIdentifier;

@end

@implementation FLTableComponent

#pragma mark Life Cycle

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
        [self registComponent];
        self.isCustomIdentifier = NO;
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    if (self = [self initWithTableView:tableView]) {
        self.isCustomIdentifier = YES;
        self.componentIdentifier = identifier;
    }
    return self;
}

#pragma mark - Setter & Getter

- (void)setSection:(NSInteger)section {
    [super setSection:section];
    if (!self.isCustomIdentifier) {
        self.componentIdentifier = [NSString stringWithFormat:@"HY_%@.Component.%zd",NSStringFromClass(self.class),self.section];
    }
}

#pragma mark HYTableComponentProtocol

- (void)registComponent {
    if (!self.tableView) {
        return;
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.cellIdentifier];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:self.headerIdentifier];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:self.footerIdentifier];
}

- (NSInteger)numberOfCells {
    return 0;
}

- (UITableViewCell *)cellForRow:(NSInteger)row {
    if (!self.tableView) {
        return nil;
    }
    return [self.tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
}

- (BOOL)tableViewShouldHighlightCell:(UITableViewCell *)cell atRow:(NSInteger)row {
    return YES;
}

- (void)tableViewDidHighlightCell:(UITableViewCell *)cell atRow:(NSInteger)row {
    
}

- (void)tableViewDidUnHighlightCell:(UITableViewCell *)cell atRow:(NSInteger)row {
    
}

- (void)tableViewWillDisplayCell:(UITableViewCell *)cell atRow:(NSInteger)row {
    // subClass override it
}

- (void)tableViewWillDisplayHeader:(UITableViewHeaderFooterView *)headerView atSection:(NSInteger)section {
    // subClass override it
}

- (void)tableViewWillDisplayFooter:(UITableViewHeaderFooterView *)headerView atSection:(NSInteger)section {
    // subClass override it
}

- (UITableViewHeaderFooterView *)headerViewAtSection:(NSInteger)section NS_REQUIRES_SUPER{
    if (!self.tableView) {
        return nil;
    }
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerIdentifier];
}

- (UITableViewHeaderFooterView *)footerViewAtSection:(NSInteger)section NS_REQUIRES_SUPER{
    if (!self.tableView) {
        return nil;
    }
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerIdentifier];
}

- (CGFloat)heightForCellAtRow:(NSInteger)row {
    return KHYDefaultCellHeight;
}

- (CGFloat)heightForHeader {
    return CGFLOAT_MIN;
}

- (CGFloat)heightForFooter {
    return CGFLOAT_MIN;
}

@end

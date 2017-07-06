//
//  HYTableViewHandler.h
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTableComponent.h"
@import UIKit;
@class HYTableViewHandler;

@protocol HYTableViewHandlerDelegate <NSObject>
@optional
- (void)tableViewDidClick:(HYTableViewHandler *)handler cellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewDidClick:(HYTableViewHandler *)handler headerAtSection:(NSInteger)section;

- (void)tableViewDidClick:(HYTableViewHandler *)handler footerAtSection:(NSInteger)section;

@end

@interface HYTableViewHandler : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak, readonly) UITableView *tableView;

@property (nonatomic, strong) NSArray<FLTableComponent *> *components;

@property (nonatomic, weak) id<HYTableViewHandlerDelegate> delegate;

//- (void)set

- (FLTableComponent *)componentByIdentifier:(NSString *)identifier;

- (void)reloadComponents;
- (void)reloadComponent:(FLTableComponent *)component;

- (void)removeComponentByIdentifier:(NSString *)identifier type:(FLComponentRemoveType)type;
- (void)removeComponent:(FLTableComponent *)component;
- (void)removeComponentAtIndex:(NSInteger)index;

- (void)addComponent:(FLTableComponent *)component afterSection:(NSInteger)section;
- (void)addComponents:(NSArray<FLTableComponent *> *)components afterSection:(NSInteger)section;
- (void)addComponent:(FLTableComponent *)component;

- (void)replaceComponent:(FLTableComponent *)matchComponent byReplaceComponent:(FLTableComponent *)replacementComponent;

- (void)exchangeComponent:(FLTableComponent *)matchComponent byExchangeComponent:(FLTableComponent *)exchangementComponent;
@end

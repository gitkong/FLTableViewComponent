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
@class FLTableViewHandler;

@protocol FLTableViewHandlerDelegate <NSObject>
@optional
- (void)tableViewDidClick:(FLTableViewHandler *)handler cellAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewDidClick:(FLTableViewHandler *)handler headerAtSection:(NSInteger)section;

- (void)tableViewDidClick:(FLTableViewHandler *)handler footerAtSection:(NSInteger)section;

@end

@interface FLTableViewHandler : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak, readonly) UITableView *tableView;

@property (nonatomic, strong) NSArray<FLTableComponent *> *components;

@property (nonatomic, weak) id<FLTableViewHandlerDelegate> delegate;

//- (void)set

- (FLTableComponent *)componentByIdentifier:(NSString *)identifier;

- (void)reloadComponents;
- (void)reloadComponent:(FLTableComponent *)component;
- (void)reloadComponents:(NSArray <FLTableComponent *>*)components;

- (void)removeComponentByIdentifier:(NSString *)identifier type:(FLComponentRemoveType)type;
- (void)removeComponent:(FLTableComponent *)component;
- (void)removeComponentAtIndex:(NSInteger)index;

- (void)addComponent:(FLTableComponent *)component afterSection:(NSInteger)section;
- (void)addComponent:(FLTableComponent *)component afterComponent:(FLTableComponent *)afterComponent;
- (void)addComponent:(FLTableComponent *)component afterIdentifier:(NSString *)componentIdentifier;
- (void)addComponents:(NSArray<FLTableComponent *> *)components afterSection:(NSInteger)section;
- (void)addComponent:(FLTableComponent *)component;

- (void)replaceComponent:(FLTableComponent *)matchComponent byReplaceComponent:(FLTableComponent *)replacementComponent;

- (void)exchangeComponent:(FLTableComponent *)matchComponent byExchangeComponent:(FLTableComponent *)exchangementComponent;
@end

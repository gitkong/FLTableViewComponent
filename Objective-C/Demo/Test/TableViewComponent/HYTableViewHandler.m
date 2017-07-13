//
//  HYTableViewHandler.m
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "HYTableViewHandler.h"
#import "FLTableComponent.h"
#import "UITableViewHeaderFooterView+Component.h"
#import "NSString+Empty.h"

@interface HYTableViewHandler ()

@property (nonatomic, strong) NSMutableDictionary *componentDict;

@property (nonatomic, strong) NSMutableArray<FLTableComponent *> *insideComponents;

@end

@implementation HYTableViewHandler

#pragma mark Public Method

- (FLTableComponent *)componentByIdentifier:(NSString *)identifier {
    if (self.componentDict.count && identifier.isNotEmpty) {
        return [self.componentDict valueForKey:identifier];
    }
    return nil;
}

- (void)removeComponentByIdentifier:(NSString *)identifier type:(FLComponentRemoveType)type {
    @synchronized (self) {
        if ([self isHaveComponents]) {
            FLTableComponent *component = [self componentByIdentifier:identifier];
            if (component) {
                if (type == FLComponentRemoveTypeAll) {
                    [self.insideComponents removeObject:component];
                }
                else if (type == FLComponentRemoveTypeLast) {
                    [self.insideComponents removeObjectAtIndex:component.section];
                }
                [self refreshComponents];
            }
        }
    }
}

- (void)removeComponent:(FLTableComponent *)component {
    @synchronized (self) {
        if (component) {
            [self.insideComponents removeObjectAtIndex:component.section];
            [self refreshComponents];
        }
    }
}

- (void)removeComponentAtIndex:(NSInteger)index {
    @synchronized (self) {
        if ([self isHaveComponents] && index < self.components.count) {
            FLTableComponent *component = self.components[index];
            [self removeComponent:component];
        }
    }
}

- (void)reloadComponents {
    if (self.tableView) {
        [self.tableView reloadData];
    }
}

- (void)reloadComponent:(FLTableComponent *)component {
    if (self.tableView && component && component.section < self.components.count) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:component.section] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)addComponent:(FLTableComponent *)component afterSection:(NSInteger)section {
    @synchronized (self) {
        if ([self isHaveComponents] && section < self.components.count && component) {
            [self.insideComponents insertObject:component atIndex:section];
            [self refreshComponents];
        }
    }
}

- (void)addComponents:(NSArray<FLTableComponent *> *)components afterSection:(NSInteger)section {
    @synchronized (self) {
        if ([self isHaveComponents] && section < self.components.count && components) {
            NSUInteger i = section;
            for (FLTableComponent *component in components) {
                i++;
                if (i > self.components.count) {
                    break;
                }
                [self.insideComponents insertObject:component atIndex:i];
            }
            [self refreshComponents];
        }
    }
}

- (void)addComponent:(FLTableComponent *)component {
    @synchronized (self) {
        if ([self isHaveComponents] && component) {
            [self.insideComponents addObject:component];
            [self refreshComponents];
        }
    }
}

- (void)replaceComponent:(FLTableComponent *)matchComponent byReplaceComponent:(FLTableComponent *)replacementComponent {
    @synchronized (self) {
        if ([self isHaveComponents] && matchComponent) {
            if (replacementComponent) {
                [self.insideComponents replaceObjectAtIndex:matchComponent.section withObject:replacementComponent];
                [self refreshComponents];
            }
            else {
                [self removeComponent:matchComponent];
            }
        }
    }
}

- (void)exchangeComponent:(FLTableComponent *)matchComponent byExchangeComponent:(FLTableComponent *)exchangementComponent {
    @synchronized (self) {
        if ([self isHaveComponents] && matchComponent) {
            if (exchangementComponent) {
                [self.insideComponents exchangeObjectAtIndex:matchComponent.section withObjectAtIndex:exchangementComponent.section];
                [self refreshComponents];
            }
        }
    }
}

#pragma mark - Private Method

- (void)refreshComponents {
    if (self.insideComponents && self.insideComponents.count) {
        [self.componentDict removeAllObjects];
        for (NSInteger section = 0; section < self.insideComponents.count; section ++) {
            FLTableComponent *component = self.insideComponents[section];
            component.section = section;
            if (component.componentIdentifier) {
                [self.componentDict setValue:component forKey:component.componentIdentifier];
            }
        }
    }
    [self reloadComponents];
}


#pragma mark UITableViewDelegate & UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.components.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isHaveComponents && section < self.components.count && section < self.components.count) {
        return [self.components[section] numberOfCells];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveComponents && indexPath.section < self.components.count) {
        FLTableComponent *component = self.components[indexPath.section];
        component.section = indexPath.section;
        return [component cellForRow:indexPath.row];
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveComponents && indexPath.section < self.components.count) {
        FLTableComponent *component = self.components[indexPath.section];
        component.section = indexPath.section;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        return [component tableViewShouldHighlightCell:cell atRow:indexPath.row];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveComponents && indexPath.section < self.components.count) {
        FLTableComponent *component = self.components[indexPath.section];
        component.section = indexPath.section;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        return [component tableViewDidHighlightCell:cell atRow:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveComponents && indexPath.section < self.components.count) {
        FLTableComponent *component = self.components[indexPath.section];
        component.section = indexPath.section;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        return [component tableViewDidUnHighlightCell:cell atRow:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveComponents && indexPath.section < self.components.count) {
        FLTableComponent *component = self.components[indexPath.section];
        component.section = indexPath.section;
        [component tableViewWillDisplayCell:cell atRow:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveComponents && indexPath.section < self.components.count) {
        FLTableComponent *component = self.components[indexPath.section];
        component.section = indexPath.section;
        return [component heightForCellAtRow:indexPath.row];
    }
    return KHYDefaultCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewDidClick:cellAtIndexPath:)]) {
        [self.delegate tableViewDidClick:self cellAtIndexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isHaveComponents && section < self.components.count) {
        FLTableComponent *component = self.components[section];
        component.section = section;
        UITableViewHeaderFooterView *headerView = [component headerViewAtSection:section];
        headerView.section = section;
        [self addTapGestureTo:headerView withEvent:@selector(headerViewDidClick:)];
        return headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.isHaveComponents && section < self.components.count) {
        FLTableComponent *component = self.components[section];
        component.section = section;
        UITableViewHeaderFooterView *footerView = [component footerViewAtSection:section];
        footerView.section = section;
        [self addTapGestureTo:footerView withEvent:@selector(footerViewDidClick:)];
        return footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isHaveComponents && section < self.components.count) {
        FLTableComponent *component = self.components[section];
        component.section = section;
        return [component heightForHeader];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.isHaveComponents && section < self.components.count) {
        FLTableComponent *component = self.components[section];
        component.section = section;
        return [component heightForFooter];
    }
    return CGFLOAT_MIN;
}

#pragma mark Private Method

- (BOOL)isHaveComponents {
    return self.components && self.components.count;
}

- (void)addTapGestureTo:(UIView *)view withEvent:(SEL)selector {
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [view addGestureRecognizer:tapG];
}

- (void)headerViewDidClick:(UIGestureRecognizer *)reg {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewDidClick:headerAtSection:)]) {
        if ([reg.view isKindOfClass:[UITableViewHeaderFooterView class]]) {
            UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)reg.view;
            [self.delegate tableViewDidClick:self headerAtSection:headerView.section];
        }
    }
}

- (void)footerViewDidClick:(UIGestureRecognizer *)reg {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewDidClick:footerAtSection:)]) {
        if ([reg.view isKindOfClass:[UITableViewHeaderFooterView class]]) {
            UITableViewHeaderFooterView *footerView = (UITableViewHeaderFooterView *)reg.view;
            [self.delegate tableViewDidClick:self footerAtSection:footerView.section];
        }
    }
}

#pragma mark Setter & Getter

- (void)setComponents:(NSArray<FLTableComponent *> *)components {
    [self.insideComponents removeAllObjects];
    [self.insideComponents addObjectsFromArray:components];
    self.tableView.handler = self;
    [self refreshComponents];
}

//- (void)setInsideComponents:(NSMutableArray<HYTableComponent *> *)insideComponents {
//    _insideComponents = insideComponents;
//    
//}

- (NSArray<FLTableComponent *> *)components {
    return self.insideComponents;
}

- (NSMutableArray<FLTableComponent *> *)insideComponents {
    if (_insideComponents == nil) {
        _insideComponents = [NSMutableArray array];
    }
    return _insideComponents;
}

- (NSMutableDictionary *)componentDict {
    if (_componentDict == nil) {
        _componentDict = [NSMutableDictionary dictionary];
    }
    return _componentDict;
}

- (UITableView *)tableView {
    if (self.isHaveComponents) {
        return self.components.firstObject.tableView;
    }
    return nil;
}

@end

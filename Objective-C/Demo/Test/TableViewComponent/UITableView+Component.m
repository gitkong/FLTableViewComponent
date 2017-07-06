//
//  UITableView+Component.m
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "UITableView+Component.h"
#import "HYTableViewHandler.h"
#import <objc/runtime.h>

static char *KHYTableViewHandlerKey = "KHYTableViewHandlerKey";

@implementation UITableView (Component)

- (void)setHandler:(HYTableViewHandler *)handler {
    objc_setAssociatedObject(self, &KHYTableViewHandlerKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = handler;
    self.dataSource = handler;
}

- (HYTableViewHandler *)handler {
    return objc_getAssociatedObject(self, &KHYTableViewHandlerKey);
}

- (void)registerNibClass:(Class)nibClass forCellReuseIdentifier:(NSString *)identifier {
    if (nibClass && identifier) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil] forCellReuseIdentifier:identifier];
    }
}

- (void)registerNibClass:(Class)nibClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
    if (nibClass && identifier) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
    }
}

@end

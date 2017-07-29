//
//  UITableView+Component.m
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "UITableView+Component.h"
#import "FLTableViewHandler.h"
#import <objc/runtime.h>

static char *KFLTableViewHandlerKey = "KFLTableViewHandlerKey";

@implementation UITableView (Component)

- (void)setHandler:(FLTableViewHandler *)handler {
    objc_setAssociatedObject(self, &KFLTableViewHandlerKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.delegate = handler;
    self.dataSource = handler;
}

- (FLTableViewHandler *)handler {
    return objc_getAssociatedObject(self, &KFLTableViewHandlerKey);
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

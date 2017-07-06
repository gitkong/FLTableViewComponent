//
//  UITableViewHeaderFooterView+Component.m
//  live
//
//  Created by 孔凡列 on 2017/6/28.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "UITableViewHeaderFooterView+Component.h"
#import <objc/runtime.h>

static char *KHYTableHeaderFooterViewSectionStaticKey = "KHYTableHeaderFooterViewSectionStaticKey";

@implementation UITableViewHeaderFooterView (Component)

- (void)setSection:(NSInteger)section {
    objc_setAssociatedObject(self, &KHYTableHeaderFooterViewSectionStaticKey, @(section), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)section {
    NSNumber *num = objc_getAssociatedObject(self, &KHYTableHeaderFooterViewSectionStaticKey);
    return num.integerValue;
}

@end

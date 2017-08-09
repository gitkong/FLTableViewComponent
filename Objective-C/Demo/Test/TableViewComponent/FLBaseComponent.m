//
//  HYBaseComponent.m
//  live
//
//  Created by 孔凡列 on 2017/6/26.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "FLBaseComponent.h"

@implementation FLBaseComponent

- (NSString *)cellIdentifier {
    return [NSString stringWithFormat:@"HY_%@.Cell",NSStringFromClass(self.class)];
}

- (NSString *)headerIdentifier {
    return [NSString stringWithFormat:@"HY_%@.Header",NSStringFromClass(self.class)];
}

- (NSString *)footerIdentifier {
    return [NSString stringWithFormat:@"HY_%@.Footer",NSStringFromClass(self.class)];
}

- (void)registComponent {
    // subClass override it
}

- (void)reloadSelfComponent {
    
}

@end

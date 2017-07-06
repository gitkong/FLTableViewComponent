//
//  NSString+Empty.m
//  Test
//
//  Created by 孔凡列 on 2017/7/6.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

- (BOOL)isNotEmpty {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

@end

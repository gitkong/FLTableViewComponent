//
//  TestComponentTwo.m
//  Test
//
//  Created by 孔凡列 on 2017/7/6.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "TestComponentTwo.h"
#import "TestTableViewCellTwo.h"

@implementation TestComponentTwo

- (void)registComponent {
    [super registComponent];
    [self.tableView registerNibClass:[TestTableViewCellTwo class] forCellReuseIdentifier:self.cellIdentifier];
}

- (NSInteger)numberOfCells {
    return 3;
}

- (UITableViewCell *)cellForRow:(NSInteger)row {
//    TestTableViewCellTwo *cell = (TestTableViewCellTwo *)[super cellForRow:row];
//    cell.label.text =
    return [super cellForRow:row];
}

- (UITableViewHeaderFooterView *)headerViewAtSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [super headerViewAtSection:section];
    header.textLabel.text = @"gitKong_header_two";
    return header;
}

- (CGFloat)heightForHeader {
    return 60;
}

@end

//
//  TestComponentOne.m
//  Test
//
//  Created by 孔凡列 on 2017/7/6.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "TestComponentOne.h"
#import "TestTableViewCellOne.h"

@implementation TestComponentOne

- (void)registComponent {
    [super registComponent];
    [self.tableView registerClass:[TestTableViewCellOne class] forCellReuseIdentifier:self.cellIdentifier];
}

- (NSInteger)numberOfCells {
    return 1;
}

- (UITableViewCell *)cellForRow:(NSInteger)row {
    TestTableViewCellOne *cell = (TestTableViewCellOne *)[super cellForRow:row];
    cell.textLabel.text = @"gitKong_one";
    return cell;
}

- (UITableViewHeaderFooterView *)footerViewAtSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = [super footerViewAtSection:section];
    footer.textLabel.text = @"gitKong_footerr_one";
    return footer;
}

- (CGFloat)heightForFooter {
    return 40;
}

@end

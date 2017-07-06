//
//  TestViewController.m
//  Test
//
//  Created by 孔凡列 on 2017/7/6.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "TestViewController.h"
#import "TestComponentOne.h"
#import "TestComponentTwo.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.methodName style:UIBarButtonItemStyleDone target:self action:NSSelectorFromString(self.methodName)];
    
    TestComponentOne *oneComponent = [[TestComponentOne alloc] initWithTableView:self.tableView identifier:@"One"];
    
    TestComponentTwo *twoComponent = [[TestComponentTwo alloc] initWithTableView:self.tableView identifier:@"Two"];
    
    self.components = @[oneComponent, twoComponent];
    
    [self.handler reloadComponents];
}

- (void)exchange {
    [self.handler exchangeComponent:[self.handler componentByIdentifier:@"One"] byExchangeComponent:[self.handler componentByIdentifier:@"Two"]];
}

- (void)add {
    TestComponentOne *oneComponent = [[TestComponentOne alloc] initWithTableView:self.tableView identifier:@"Third"];
    [self.handler addComponent:oneComponent afterSection:0];
}

- (void)replace {
    [self.handler replaceComponent:[self.handler componentByIdentifier:@"Two"] byReplaceComponent:[self.handler componentByIdentifier:@"One"]];
}

- (void)remove {
    [self.handler removeComponent:[self.handler componentByIdentifier:@"One"]];
}

@end

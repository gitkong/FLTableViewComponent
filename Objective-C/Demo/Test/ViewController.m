//
//  ViewController.m
//  Test
//
//  Created by 孔凡列 on 2017/7/6.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)add:(id)sender {
    [self pushTestWithMethodName:@"add"];
}
- (IBAction)exchange:(id)sender {
    [self pushTestWithMethodName:@"exchange"];
}
- (IBAction)replace:(id)sender {
    [self pushTestWithMethodName:@"replace"];
}
- (IBAction)remove:(id)sender {
    [self pushTestWithMethodName:@"remove"];
}

- (void)pushTestWithMethodName:(NSString *)name {
    TestViewController *vc = [[TestViewController alloc] init];
    vc.methodName = name;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

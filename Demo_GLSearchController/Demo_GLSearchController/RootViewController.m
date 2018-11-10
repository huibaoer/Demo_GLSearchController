//
//  RootViewController.m
//  Demo_UISearchController
//
//  Created by GrayLeo on 2018/11/8.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import "RootViewController.h"
#import "CountrySelectController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonAction:(id)sender {
    CountrySelectController *vc = [[CountrySelectController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

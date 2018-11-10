//
//  GLSearchResultController.m
//  Demo_GLSearchController
//
//  Created by GrayLeo on 2018/11/10.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import "GLSearchResultController.h"

@interface GLSearchResultController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation GLSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)updateSearchResult:(NSArray *)dataArray {
    _dataArray = dataArray;
    [_tableView reloadData];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end

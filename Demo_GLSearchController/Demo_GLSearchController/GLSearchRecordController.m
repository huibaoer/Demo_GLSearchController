//
//  GLSearchRecordController.m
//  Demo_GLSearchController
//
//  Created by GrayLeo on 2018/11/10.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import "GLSearchRecordController.h"

@interface GLSearchRecordController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLSearchRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"搜索历史";
    } else {
        cell.textLabel.text = [[NSNumber numberWithInteger:indexPath.row] stringValue];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) return;
    
    if ([_delegate respondsToSelector:@selector(GL_searchRecordController:didSelectSearchRecord:)]) {
        NSString *value = [[NSNumber numberWithInteger:indexPath.row] stringValue];
        [_delegate GL_searchRecordController:self didSelectSearchRecord:value];
    }
}

@end

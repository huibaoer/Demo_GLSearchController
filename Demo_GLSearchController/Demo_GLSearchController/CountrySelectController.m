//
//  CountrySelectController.m
//  Demo_UISearchController
//
//  Created by GrayLeo on 2018/11/8.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import "CountrySelectController.h"
#import "GLSearchBar.h"
#import "GLSearchBarController.h"
#import "GLSearchResultController.h"
#import "GLSearchRecordController.h"

@interface CountrySelectController () <UITableViewDelegate, UITableViewDataSource, GLSearchBarControllerDelegate, GLSearchResultsUpdating, GLSearchRecordControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *searchBarContainer;
@property (strong, nonatomic) IBOutlet GLSearchBar *searchBar;
@property (nonatomic, weak) GLSearchBarController *searchBarController;



@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CountrySelectController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        NSString *value = [[NSNumber numberWithInt:i] stringValue];
        [_dataArray addObject:value];
    }
    
    self.title = @"选择国家或地区";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_left_gray"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];

    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _searchBar.textField.placeholder = @"请输入国家或地区";
    _searchBar.textAlignment = GLSearchBarTextAlignmentCenter;
    [_searchBar.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableHeaderView = _searchBarContainer;
    
}

- (void)searchAction {
    GLSearchResultController *result = [[GLSearchResultController alloc] init];
    GLSearchRecordController *record = [[GLSearchRecordController alloc] init];
    record.delegate = self;
    
    GLSearchBarController *searchVC = [[GLSearchBarController alloc] initWithEvokeSearchBar:_searchBar searchResultController:result searchRecordController:record];
    searchVC.delegate = self;
    searchVC.searchResultsUpdater = self;
    [searchVC showWithController:self];
    _searchBarController = searchVC;
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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


#pragma mark - GLSearchBarControllerDelegate
- (void)GL_willPresentSearchController:(GLSearchBarController *)searchController {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)GL_didPresentSearchController:(GLSearchBarController *)searchController {
    
}

- (void)GL_willDismissSearchController:(GLSearchBarController *)searchController {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)GL_didDismissSearchController:(GLSearchBarController *)searchController {
    
}

#pragma mark - GLSearchResultsUpdating
- (void)GL_updateSearchResultsForSearchController:(GLSearchBarController *)searchController {
    NSString *searchText = searchController.searchBar.textField.text;
    
    NSMutableArray *retArray = [NSMutableArray array];
    for (NSString *value in _dataArray) {
        if ([value containsString:searchText]) {
            [retArray addObject:value];
        }
    }
    [(GLSearchResultController *)searchController.searchResultController updateSearchResult:retArray];
}

#pragma mark - GLSearchRecordControllerDelegate
- (void)GL_searchRecordController:(GLSearchRecordController *)searchRecordController didSelectSearchRecord:(NSString *)searchRecord {
    [_searchBarController updateSearchText:searchRecord];
}
@end

















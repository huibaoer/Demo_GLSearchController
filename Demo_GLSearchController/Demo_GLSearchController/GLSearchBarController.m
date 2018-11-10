//
//  GLSearchBarController.m
//  Demo_GLSearchController
//
//  Created by GrayLeo on 2018/11/9.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import "GLSearchBarController.h"

CGFloat const kAnimationDuration = 0.2;


@interface GLSearchBarController ()
@property (strong, nonatomic) IBOutlet UIView *headerView;//透明
@property (strong, nonatomic) IBOutlet UIView *headerBgView;//白色
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) GLSearchBar *searchBar;
@property (strong, nonatomic) GLSearchBar *outsideSearchBar;
@property (strong, nonatomic) UIViewController *searchResultController;
@property (strong, nonatomic) UIViewController *searchRecordController;
@property (nonatomic, assign) CGRect EvokeSearchBarRect;

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) UIViewController *curContainerController;



@end

@implementation GLSearchBarController

- (void)dealloc {
    
}

- (instancetype)initWithEvokeSearchBar:(GLSearchBar *)searchBar searchResultController:(UIViewController *)searchResultController searchRecordController:(UIViewController *)searchRecordController {
    self = [super initWithNibName:@"GLSearchBarController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        CGRect rect = [searchBar.superview convertRect:searchBar.frame toView:[UIApplication sharedApplication].keyWindow];
        _EvokeSearchBarRect = rect;
        _outsideSearchBar = searchBar;
        _searchResultController = searchResultController;
        _searchRecordController = searchRecordController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.headerBgView.alpha = 0;
    self.containerView.alpha = 0;
    
    //searchBar
    GLSearchBar *searchBar = [[GLSearchBar alloc] init];
    searchBar.searchBtn.hidden = YES;
    searchBar.textField.text = _outsideSearchBar.textField.text;
    searchBar.textField.placeholder = _outsideSearchBar.textField.placeholder;
    [searchBar.textField addTarget:self action:@selector(searchTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    searchBar.textAlignment = _outsideSearchBar.textAlignment;
    [_headerView addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.EvokeSearchBarRect.origin.x);
        make.trailing.mas_equalTo(SCREEN_WIDTH - self.EvokeSearchBarRect.origin.x - self.EvokeSearchBarRect.size.width);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.EvokeSearchBarRect.origin.y);
    }];
    _searchBar = searchBar;
    
    //containerView
    _curContainerController = _searchRecordController;
    [self addChildViewController:_curContainerController];
    [self.containerView addSubview:_curContainerController.view];
    [_curContainerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.containerView);
    }];
    [_curContainerController didMoveToParentViewController:self];
}

- (void)replaceViewController:(UIViewController *)oldVC newViewController:(UIViewController *)newVC {
    [self addChildViewController:newVC];
    [oldVC willMoveToParentViewController:nil];
    @WeakObj(self);
    [self transitionFromViewController:oldVC toViewController:newVC duration:0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        @StrongObj(self);
        if (finished) {
            [oldVC removeFromParentViewController];
            [newVC didMoveToParentViewController:self];
            [newVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.containerView);
            }];
            self.curContainerController = newVC;
        }
    }];
}

- (void)showWithController:(UIViewController *)presentingController {
    if ([self.delegate respondsToSelector:@selector(GL_willPresentSearchController:)]) {
        [self.delegate GL_willPresentSearchController:self];
    }
    
    [presentingController presentViewController:self animated:NO completion:^{
        
        [self.searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.trailing.mas_equalTo(self.cancelBtn.mas_leading).with.offset(-8);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(15);
        }];
        self.searchBar.textAlignment = GLSearchBarTextAlignmentLeft;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.headerBgView.alpha = 1;
            self.containerView.alpha = 1;
            [self.headerView layoutIfNeeded];
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(GL_didPresentSearchController:)]) {
                [self.delegate GL_didPresentSearchController:self];
            }
        }];
    }];
}

- (void)dismiss {
    if ([self.delegate respondsToSelector:@selector(GL_willDismissSearchController:)]) {
        [self.delegate GL_willDismissSearchController:self];
    }
    
    [_searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.EvokeSearchBarRect.origin.x);
        make.trailing.mas_equalTo(SCREEN_WIDTH - self.EvokeSearchBarRect.origin.x - self.EvokeSearchBarRect.size.width);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.EvokeSearchBarRect.origin.y);
    }];
    _searchBar.textAlignment = _outsideSearchBar.textAlignment;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.headerBgView.alpha = 0;
        self.containerView.alpha = 0;
        [self.headerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        
        if ([self.delegate respondsToSelector:@selector(GL_didDismissSearchController:)]) {
            [self.delegate GL_didDismissSearchController:self];
        }
    }];
}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismiss];
}

- (void)updateSearchText:(NSString *)searchText {
    _searchBar.textField.text = searchText;
    [self searchTextFieldEditingChanged:_searchBar.textField];
}

#pragma mark - SearchTextField
- (void)searchTextFieldEditingChanged:(UITextField *)textField {
    if (textField.text.length > 0) {
        if (_curContainerController == _searchResultController) return;
        [self replaceViewController:_curContainerController newViewController:_searchResultController];
    } else {
        if (_curContainerController == _searchRecordController) return;
        [self replaceViewController:_curContainerController newViewController:_searchRecordController];
    }
    
    if ([_searchResultsUpdater respondsToSelector:@selector(GL_updateSearchResultsForSearchController:)]) {
        [_searchResultsUpdater GL_updateSearchResultsForSearchController:self];
    }
}




@end



















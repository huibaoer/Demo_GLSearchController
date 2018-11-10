//
//  GLSearchBarController.h
//  Demo_GLSearchController
//
//  Created by GrayLeo on 2018/11/9.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLSearchBar.h"

NS_ASSUME_NONNULL_BEGIN
@class GLSearchBarController;


@protocol GLSearchBarControllerDelegate <NSObject>
@optional
- (void)GL_willPresentSearchController:(GLSearchBarController *)searchController;
- (void)GL_didPresentSearchController:(GLSearchBarController *)searchController;
- (void)GL_willDismissSearchController:(GLSearchBarController *)searchController;
- (void)GL_didDismissSearchController:(GLSearchBarController *)searchController;

@end


@protocol GLSearchResultsUpdating <NSObject>
@required
- (void)GL_updateSearchResultsForSearchController:(GLSearchBarController *)searchController;
@end




@interface GLSearchBarController : UIViewController
@property (nonatomic, weak) id<GLSearchBarControllerDelegate> delegate;
@property (nonatomic, weak) id<GLSearchResultsUpdating> searchResultsUpdater;
@property (nonatomic, readonly) GLSearchBar *searchBar;
@property (nonatomic, readonly) UIViewController *searchResultController;
@property (nonatomic, readonly) UIViewController *searchRecordController;

- (instancetype)initWithEvokeSearchBar:(GLSearchBar *)searchBar searchResultController:(UIViewController *)searchResultController searchRecordController:(UIViewController *)searchRecordController;

- (void)showWithController:(UIViewController *)presentingController;

- (void)dismiss;

- (void)updateSearchText:(NSString *)searchText;

@end

NS_ASSUME_NONNULL_END

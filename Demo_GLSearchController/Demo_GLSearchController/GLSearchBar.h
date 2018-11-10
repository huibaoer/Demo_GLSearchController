//
//  GLSearchBar.h
//  Demo_GLSearchController
//
//  Created by GrayLeo on 2018/11/9.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GLSearchBarTextAlignment) {
    GLSearchBarTextAlignmentLeft = 0,
    GLSearchBarTextAlignmentCenter,
};

@interface GLSearchBar : UIView
@property (strong, nonatomic) IBOutlet UIImageView *bgImgView;
@property (strong, nonatomic) IBOutlet UIImageView *searchIcon;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonatomic, assign) GLSearchBarTextAlignment textAlignment;
@end

NS_ASSUME_NONNULL_END

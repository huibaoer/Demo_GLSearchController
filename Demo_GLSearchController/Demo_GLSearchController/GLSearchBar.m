//
//  GLSearchBar.m
//  Demo_GLSearchController
//
//  Created by GrayLeo on 2018/11/9.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import "GLSearchBar.h"


@interface GLSearchBar ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *inputContainer;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputContainerLeading;
@end


@implementation GLSearchBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [[NSBundle mainBundle] loadNibNamed:@"GLSearchBar" owner:self options:nil];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _bgImgView.layer.cornerRadius = 20;
    [self bringSubviewToFront:_searchBtn];
}

- (void)setTextAlignment:(GLSearchBarTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    if (_textAlignment == GLSearchBarTextAlignmentLeft) {
        _inputContainerLeading.active = YES;
    } else if (_textAlignment == GLSearchBarTextAlignmentCenter) {
        _inputContainerLeading.active = NO;
    }
}




@end

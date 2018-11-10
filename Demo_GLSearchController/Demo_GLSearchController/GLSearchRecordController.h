//
//  GLSearchRecordController.h
//  Demo_GLSearchController
//
//  Created by GrayLeo on 2018/11/10.
//  Copyright © 2018年 GrayLeo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GLSearchRecordController;

@protocol GLSearchRecordControllerDelegate <NSObject>
@required
- (void)GL_searchRecordController:(GLSearchRecordController *)searchRecordController didSelectSearchRecord:(NSString *)searchRecord;
@end



@interface GLSearchRecordController : UIViewController
@property (nonatomic, weak) id<GLSearchRecordControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

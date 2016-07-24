//
//  MyImageView.h
//  UIImagePickerVIewControllerDemo
//
//  Created by Fogao Zhang on 16/7/23.
//  Copyright © 2016年 Fogao Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageView : UIImageView

- (nullable instancetype)initWithFrame:(CGRect)frame withTarget:(nullable id)target action:(nullable SEL)deleteAction tag:(NSInteger)tag andTapImageViewAction:(nullable SEL)tapAction;

@end

//
//  MyImageView.m
//  UIImagePickerVIewControllerDemo
//
//  Created by Fogao Zhang on 16/7/23.
//  Copyright © 2016年 Fogao Zhang. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame withTarget:(id)target action:(SEL)deleteAction tag:(NSInteger)tag andTapImageViewAction:(SEL)tapAction
{
    
    self = [super initWithFrame:frame];
    if (self) {
//        self.tag = tag;
        /**
         *  添加删除图标
         */
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"ImageResources.bundle/searchList_btn_delete"] forState:UIControlStateNormal];
        btn.tag       = tag;
        btn.frame     = CGRectMake(self.frame.size.width-20, -5, 25, 25);
        [btn addTarget:target action:deleteAction forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
      
        /**
         添加单击手势
         */
        UITapGestureRecognizer *oneTapGestuer = [[UITapGestureRecognizer alloc]initWithTarget:target action:tapAction];
        [self addGestureRecognizer:oneTapGestuer];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}
@end

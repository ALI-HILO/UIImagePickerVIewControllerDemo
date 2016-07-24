//
//  ImageScrollView.h
//  大的ScrollView包含小的scrollView
//
//  Created by etcxm on 16/5/26.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageScrollView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic, strong)UIImageView *theIamgeView;

@end

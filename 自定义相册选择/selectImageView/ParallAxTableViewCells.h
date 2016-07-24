//
//  ParallAxTableViewCells.h
//  Opening The Eyes
//
//  Created by Hy_Mac on 15/4/24.
//  Copyright (c) 2015年 Hy_Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PARALLAXCELL_HEIGHT 300.0
#define PARALLAXCELL_HEIGHT1 200.0
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface Button : UIButton

@end

@interface ParallAxTableViewCells : UITableViewCell

@property (nonatomic, strong) UIImageView *parallaxImageView;

@property (nonatomic, strong) UILabel *TitleOne;

@property (nonatomic, copy) NSString * TitleTwo;

- (void)setParallaxImageViewWithImage:(UIImage *)image onTableView:(UITableView *)tableView toView:(UIView *)view atRows:(NSInteger)row;

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
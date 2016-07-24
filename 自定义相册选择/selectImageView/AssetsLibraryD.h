//
//  AssetsLibraryD.h
//  TestProject
//
//  Created by Apple on 15/6/25.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^UpDataBlock)(NSArray *ImgsData);
typedef void(^UserIsOpen)(BOOL is);

@interface AssetsLibraryD : NSObject

@property (nonatomic,strong) UpDataBlock GetImageBlock;

@property (nonatomic,strong) UserIsOpen isopen;

@property (nonatomic,strong) NSMutableArray *UpDataImages;

@property (nonatomic,strong) NSMutableArray *assets;

-(void)setUserIsOpen:(UserIsOpen)block;

-(void)UpDataBlock:(UpDataBlock)block;

-(void)GetPhotosBlock:(UpDataBlock)block;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
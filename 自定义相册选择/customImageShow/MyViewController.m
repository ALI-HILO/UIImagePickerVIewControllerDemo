//
//  MyViewController.m
//  UIImagePickerVIewControllerDemo
//
//  Created by Fogao Zhang on 16/7/23.
//  Copyright © 2016年 Fogao Zhang. All rights reserved.
//

#import "MyViewController.h"
#import "ParallAxTableViewCells.h"
#import "HySideScrollingImagePicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIView+ZRCategory.h"
#import "MyImageView.h"
#import "DetailImageViewController.h"

@interface MyViewController ()<UIScrollViewDelegate>
{
    UIButton        *button;
    UIScrollView    *scrollView ;
    NSMutableArray  *_theAddImageArr;
    NSMutableArray  *_theImageArr;
    
}
@property (retain, nonatomic) NSMutableArray *DataSource;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.view.backgroundColor                 = [UIColor whiteColor];
    _DataSource                               = [NSMutableArray array];
    _theAddImageArr                           = [NSMutableArray array];
    _theImageArr                              = [NSMutableArray array];

    scrollView                                = [[UIScrollView alloc]init];
    scrollView.frame                          = CGRectMake(0, 100, SCREEN_WIDTH, 150);
    scrollView.delegate                       = self;
    scrollView.scrollsToTop                   = NO;
    [scrollView setContentSize:CGSizeMake(130, 130)];
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor                = [UIColor grayColor];
    [self.view addSubview:scrollView];

    button                                    = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame                              = CGRectMake(10, 10, 130, 130);

    [button setTitle:@"添加图片" forState:UIControlStateNormal];

    button.backgroundColor                    = [UIColor brownColor];
    [button addTarget:self action:@selector(ImagePicker:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (CGPoint)createEndPointWithRadius:(CGFloat)itemExpandRadius andAngel:(CGFloat)angel
{
    return CGPointMake(self.view.bounds.size.width/2 - (self.view.bounds.size.width/4)/2 - cos(angel * M_PI/180) * itemExpandRadius,self.view.center.y - sin(angel * M_PI/180) * itemExpandRadius);
}

- (void)ImagePicker:(UIButton *)sender {
    
    HySideScrollingImagePicker *hy = [[HySideScrollingImagePicker alloc] initWithCancelStr:@"取消" otherButtonTitles:@[@"拍摄",@"从相册选择",@"更多"]];
    hy.isMultipleSelection = true;
    
    typeof(self) weak = self;
    
    [hy SeletedImages:^(NSArray *GetImages, NSInteger Buttonindex) {
        
        NSMutableArray *INDEXPaths = [NSMutableArray array];
        for (id OBJ in _DataSource) {
            NSInteger INDEX = [_DataSource indexOfObject:OBJ];
            [INDEXPaths addObject:[NSIndexPath indexPathForRow:INDEX inSection:0]];
        }
        [_DataSource removeAllObjects];
        
        for (ALAsset *asset in GetImages) {
            UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            if (image == nil) {
                
                image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
            }
            NSString *String = [NSString stringWithFormat:@"fileName:%@ \n Date:%@",asset.defaultRepresentation.filename,[asset valueForProperty: ALAssetPropertyDate]];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:image forKey:@"image"];
            [dict setObject:String forKey:@"string"];
            [weak.DataSource addObject:dict];
            
        }
        
        if (_DataSource.count != 0) {
//            [UIView animateWithDuration:0.2 animations:^{
            
                CGFloat xx = button.x;
                int a = (int)xx  / (int)button.width;
            
                NSInteger tagNum = a+444;
                if (weak.DataSource.count == 1) {
                    
                    scrollView.contentSize = CGSizeMake(button.width* (a +2) + 10 * ( a +3 ), scrollView.frame.size.height);
                    
                    
                    UIImage *image =  [[weak.DataSource objectAtIndex:0]objectForKey:@"image"];
                    
                    [_theImageArr addObject:image];
                    
                    MyImageView *imageView = [[MyImageView alloc]initWithFrame:CGRectMake(button.x, button.y, button.width, button.height) withTarget:self action:@selector(deleImageAction:) tag:tagNum andTapImageViewAction:@selector(tapImageViewAction:)];
                    imageView.tag = tagNum;
                    imageView.image = image;
                    [_theAddImageArr addObject:imageView];
                    [scrollView addSubview:imageView];
                    button.x = button.width * (a + 1) + (a + 2) * 10;
                }
                else{
                    
                    scrollView.contentSize = CGSizeMake(button.width* (a +_DataSource.count +1) + 10 * ( a + weak.DataSource.count + 2 ), scrollView.frame.size.height);

                    for (int i = 0; i < weak.DataSource.count; i++) {
                        
                        UIImage *image =  [[weak.DataSource objectAtIndex:i]objectForKey:@"image"];
                        [_theImageArr addObject:image];
                        MyImageView *theImageView = [[MyImageView alloc]initWithFrame:CGRectMake(10 * (i+a+1) + button.width * (a + i) , button.y, button.width, button.height) withTarget:self action:@selector(deleImageAction:) tag:tagNum+i andTapImageViewAction:@selector(tapImageViewAction:)];
                        theImageView.tag = tagNum+i;
                        theImageView.image = image;
                        [_theAddImageArr addObject:theImageView];
                        [scrollView addSubview:theImageView];
                    }
                    button.x = button.width * (a + weak.DataSource.count ) + ( a + weak.DataSource.count + 1) * 10;
                }
                
            if (a > 1 || weak.DataSource.count > 1) {
                
                [scrollView setContentOffset:CGPointMake(button.x - 2 * button.width - 10, 0) animated:YES];
            }
            
                
//            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                
            }];
        }
    }];
}
/**
 *  删除后   让图片位置  scrollview的内容视图 大小 相应减少
 */
#pragma mark deleImageAction 删除已选图片
- (void)deleImageAction:(UIButton *)deleBtn{
    
    MyImageView *theImageV = [scrollView viewWithTag:deleBtn.tag];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_theImageArr];
    for (UIImage *image in tempArr) {
        
        
        if (theImageV.image == image) {
            
            [_theImageArr removeObject:image];
        }
    }
    
    
    [theImageV removeFromSuperview];

    
    NSInteger deleLengthX = theImageV.width + 10;
    for (MyImageView *firstImage in _theAddImageArr) {
        
        if (firstImage.x >= theImageV.x + deleLengthX) {
            
            firstImage.x = firstImage.x - deleLengthX;
        }
    }
    [_theAddImageArr removeObject:theImageV];
    button.x = button.x - deleLengthX;
    [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width - deleLengthX , scrollView.contentSize.height)];
}
#pragma mark单击图片 查看图片
- (void)tapImageViewAction:(UITapGestureRecognizer *)tapGesture{
    
     CGPoint point = [tapGesture locationInView:scrollView];
    
     for (MyImageView *firstImage in _theAddImageArr) {
        
        if (firstImage.x  < point.x && firstImage.x+firstImage.width > point.x) {
            
//            NSLog(@"theImageArr ＝＝  %@",_theImageArr);
            DetailImageViewController *detailCtr = [[DetailImageViewController alloc]init];
            detailCtr.theImageArr = _theImageArr;
            detailCtr.selectNum = firstImage.tag - 444 + 1;
            [self presentViewController:detailCtr animated:NO completion:^{
                
            }];
        }
}

    
//    NSLog(@" 这是哪一个图片  %ld",tapGesture);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

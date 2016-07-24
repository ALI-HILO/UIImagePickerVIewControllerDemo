//
//  DetailImageViewController.m
//  UIImagePickerVIewControllerDemo
//
//  Created by Fogao Zhang on 16/7/23.
//  Copyright © 2016年 Fogao Zhang. All rights reserved.
//

#import "DetailImageViewController.h"
#import "ImageScrollView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface DetailImageViewController ()<UIScrollViewDelegate>

//@property (nonatomic, strong) UIScrollView *theImageScrollView;
@property (nonatomic, strong) UILabel         *pageLab;

@end

@implementation DetailImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBackItemAndNavigaTitileView];
    
    self.view.backgroundColor     = [UIColor blackColor];
    
    UIScrollView *theImageScrollView       = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/5, SCREEN_WIDTH, SCREEN_HEIGHT*4/5)];
    [theImageScrollView setContentSize:CGSizeMake(self.theImageArr.count * SCREEN_WIDTH, SCREEN_HEIGHT*3/5)];
    
    theImageScrollView.pagingEnabled = YES;
    theImageScrollView.delegate = self;
    for (int i = 0; i < _theImageArr.count; i++) {
        
        ImageScrollView *imageScroView = [[ImageScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH,theImageScrollView.contentSize.height)];
        imageScroView.theIamgeView.image =[self.theImageArr objectAtIndex:i];
        
        
        [theImageScrollView addSubview:imageScroView];
    }
    
    [theImageScrollView setContentOffset:CGPointMake((_selectNum - 1) * SCREEN_WIDTH, 0)];
    theImageScrollView.showsVerticalScrollIndicator = NO;
    theImageScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:theImageScrollView];

    
}

/**
 *  设置导航栏返回按钮   和 显示当前照片数目
 */
- (void)setBackItemAndNavigaTitileView{
    
    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"btn_vdo_back"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    backBtn.frame = CGRectMake(4, 27, 30, 30);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];
    
    self.pageLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 27, 60, 30)];
    self.pageLab.textAlignment = NSTextAlignmentCenter;
    self.pageLab.text = [NSString stringWithFormat:@"%ld/%ld",_selectNum,self.theImageArr.count];
    self.pageLab.textColor = [UIColor whiteColor];
    [backView addSubview:self.pageLab];
}
#pragma mark backAction 
- (void)backAction{

//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    
    
     NSInteger i = scrollView.contentOffset.x/SCREEN_WIDTH;
     self.pageLab.text = [NSString stringWithFormat:@"%ld/%ld",i+1,self.theImageArr.count];
    
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

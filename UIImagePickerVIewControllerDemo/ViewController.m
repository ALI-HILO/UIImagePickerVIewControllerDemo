//
//  ViewController.m
//  UIImagePickerVIewControllerDemo
//
//  Created by Fogao Zhang on 16/7/23.
//  Copyright © 2016年 Fogao Zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *theSCrollView;
@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftDistance;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addImageAction:(id)sender {
    
    UIImagePickerController *imagePickerCtr = [[UIImagePickerController alloc]init];
    imagePickerCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    
    
}

@end

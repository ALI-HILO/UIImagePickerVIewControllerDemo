//
//  ImageScrollView.m
//  大的ScrollView包含小的scrollView
//
//  Created by etcxm on 16/5/26.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.maximumZoomScale = 2.0;
        self.minimumZoomScale = 0.8;
        _theIamgeView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_theIamgeView];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
    }
    return self;
}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    static double lastDis;
////     UITouch *touch = [touches anyObject];
//    if (touches.count == 2) {
//        
//        NSArray *touchArr = [touches allObjects];
//        UITouch *t1 = [touchArr objectAtIndex:0];
//        UITouch *t2 = [touchArr objectAtIndex:1];
//        
//        CGPoint p1 = [t1 locationInView:self];
//        CGPoint p2 = [t2 locationInView:self];
//        
//        double  dis = sqrt( pow((p1.x - p2.x),2) + pow(p1.y - p2.y, 2));
//        
//        if (dis > lastDis) {
//            
//            NSLog(@"fangfa");
//        }
//        else{
//            NSLog(@"ffff");
//        }
//        lastDis = dis;
//    }
//                        
//    
//}
- (void)doubleTapAction:(UITapGestureRecognizer *)doubleTap
{
    if (self.zoomScale >1.0) {
        
        [self setZoomScale:1.0 animated:YES];
    }
    else{
        
        CGPoint point = [doubleTap locationInView:self];
        [self zoomToRect:CGRectMake(point.x-40, point.y-40, 80, 80) animated:YES];
    }
    
}


- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;     // return a view that will be scaled. if delegate returns nil, nothing happens
{
    return _theIamgeView;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2); // called before the scroll view begins zooming its content
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

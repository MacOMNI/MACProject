//
//  MACNavigationController.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/20.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import "MACNavigationController.h"
//#import "UINavigationController+KMNavigationBarTransition.h"
@interface MACNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MACNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=self;
//    UIPanGestureRecognizer *recognizer = [[[UIPanGestureRecognizer alloc]initWithTarget:self
//                                                                                 action:@selector(paningGestureReceive:)]autorelease];
//    recognizer.delegate = self;
//    [recognizer delaysTouchesBegan];
//    [self.view addGestureRecognizer:recognizer];
    // Do any additional setup after loading the view.
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

//        UIView *cell = [gestureRecognizer view];
//    gestureRecognizer
//        CGPoint translation = [gestureRecognizer translationInView:[cell superview]];
//        // Check for horizontal gesture
//        if (fabsf(translation.x) > fabsf(translation.y))
//        {
//            return YES;
//        }
//        return NO;
    if (self.viewControllers.count <= 1) {
        return false;
    }
    return true;
}



//// override the push method
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//       [super pushViewController:viewController animated:animated];
//}
//
//// override the pop method
//- (UIViewController *)popViewControllerAnimated:(BOOL)animated
//{
//    
//    return [super popViewControllerAnimated:animated];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

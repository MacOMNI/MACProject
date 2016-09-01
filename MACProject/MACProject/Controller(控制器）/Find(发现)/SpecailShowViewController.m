//
//  SpecailShowViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/29.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "SpecailShowViewController.h"
#import "UIView+EAFeatureGuideView.h"
#import "EAFeatureItem.h"
@interface SpecailShowViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnFirst;
@property (weak, nonatomic) IBOutlet UIButton *btnSecond;
@property (weak, nonatomic) IBOutlet UIButton *btnThrid;
@end

@implementation SpecailShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.title = @"EAFeatureGuideView";
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"item2(null)"];

    EAFeatureItem *itemLeft = [[EAFeatureItem alloc] initWithFocusView:self.btnFirst focusCornerRadius:0 focusInsets:UIEdgeInsetsMake(-10, -10, 10, 10)];
    itemLeft.introduce = @"左上部的提示";
    itemLeft.buttonBackgroundImageName=@"bottom_bg";
    EAFeatureItem *itemMid = [[EAFeatureItem alloc] initWithFocusView:self.btnSecond focusCornerRadius:0 focusInsets:UIEdgeInsetsZero];
    itemMid.introduce = @"右中部的提示";
    itemMid.buttonBackgroundImageName=@"bottom_bg";

    EAFeatureItem *itemRight = [[EAFeatureItem alloc] initWithFocusView:self.btnThrid focusCornerRadius:0 focusInsets:UIEdgeInsetsZero];
    itemRight.introduce = @"中底部的提示";
    

    [self.navigationController.view showWithFeatureItems:@[itemLeft,itemMid,itemRight] saveKeyName:@"item2" inVersion:nil];
  
}
-(void)initData{
    
}
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

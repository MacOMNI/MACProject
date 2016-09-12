//
//  UIViewController+MAC.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 15/12/16.
//  Copyright © 2015年 MacKun. All rights reserved.
//

#import "UIViewController+MAC.h"
#import "UIImage+Additions.h"
@implementation UIViewController(MAC)


-(void)showAlertMessage:(NSString*)message
{
    [self showAlertMessage:message titile:@"提示"];

}
-(void)showAlertMessage:(NSString*)message titile:(NSString *)title{
    MMPopupItemHandler block = ^(NSInteger index){
        NSLog(@"clickd %@ button",@(index));
    };
    NSArray *items =
    @[MMItemMake(@"确定", MMItemTypeHighlight, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title
                                                         detail:message
                                                          items:items];
    
    [alertView show];
}
-(void)showAlertMessage:(NSString *)message title:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler) clickIndex{
    if (!arr||arr.count<=0) {
        return;
    }
   __block NSMutableArray *items = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:MMItemMake(obj, MMItemTypeHighlight, clickIndex)];
    }];
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:title
                                                         detail:message
                                                          items:items];
    [alertView show];
}
-(void)showSheetTitle:(NSString *)title clickArr:(NSArray *)arr click:(MMPopupItemHandler)clickIndex{
    if (!arr||arr.count<=0) {
        return;
    }

    __block NSMutableArray *items = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:MMItemMake(obj, MMItemTypeHighlight, clickIndex)];
    }];
    [[[MMSheetView alloc] initWithTitle:title
                                  items:items] show];
};

- (void)setLeftBarItemWithString:(NSString*)string
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    /**
     *  设置frame只能控制按钮的大小
     */
    btn.frame= CGRectMake(0, 0, 40, 44);
    [btn setTitle:string  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [btn addTarget:self action:@selector(leftBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -20;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];

//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithTitle:string style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemAction:)];
//    self.navigationItem.leftBarButtonItem  = leftButtonItem;
    
}
- (void)setLeftBarItemWithImage:(NSString *)imageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    /**
     *  设置frame只能控制按钮的大小
     */
    btn.frame= CGRectMake(0, 0, 40, 44);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -25;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];

//    UIBarButtonItem *leftButtonItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarItemAction:)];;
//    self.navigationItem.leftBarButtonItem=leftButtonItem;
}
- (void)setRightBarItemWithString:(NSString*)string
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    /**
     *  设置frame只能控制按钮的大小
     */
    btn.frame= CGRectMake(0, 0, 40, 44);
    [btn setTitle:string  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [btn addTarget:self action:@selector(rightBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];

//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:string style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemAction:)];
//    self.navigationItem.rightBarButtonItem  = rightButtonItem;
}
- (void)setRightBarItemWithImage:(NSString *)imageName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    /**
     *  设置frame只能控制按钮的大小
     */
    btn.frame= CGRectMake(0, 0, 40, 44);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_right = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -25;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn_right, nil];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemAction:)];
//    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)setRightBarItemImage:(UIImage *)imgage title:(NSString *)str{
    UIImage *img=[imgage imageTintedWithColor:[UIColor whiteColor]];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 60, 25)];
    [leftButton setImage:img forState:UIControlStateNormal];
    [leftButton setImage:img forState:UIControlStateHighlighted];
     [leftButton setTitle:str forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(rightBarItemAction:)forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    negativeSpacer.width = -15;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,barButton];
}

#pragma mark 左右两侧NavBarItem事件相应

- (void)leftBarItemAction:(UIBarButtonItem *)gesture
{
    if(self.navigationController.viewControllers.count>1)
    {
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)rightBarItemAction:(UIBarButtonItem *)gesture
{
    
}

#pragma mark - TabBarItem

-(void)setTabBarItemImage:(NSString *)imageName selectedImage:(NSString *)selectImageName title:(NSString *)titleString{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc ]init];
    tabBarItem.title=titleString;
    tabBarItem.image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage=[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem=tabBarItem;
}

@end

//
//  POPNumberViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/30.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "POPNumberViewController.h"
#import "POPNumberAnimation.h"
@interface POPNumberViewController ()<POPNumberAnimationDelegate>{
    GCDTimer  *timer;
}

@property (weak, nonatomic) IBOutlet UIButton *btnPopNumber;
@property (nonatomic,strong) POPNumberAnimation *popNumberAnimation;
@end

@implementation POPNumberViewController

-(void)dealloc{
    [timer destroy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)initUI{
    _popNumberAnimation = [[POPNumberAnimation alloc]init];
    _popNumberAnimation.delegate = self;

}
- (IBAction)popNumberAction:(id)sender {
   // [_btnPopNumber setBackgroundColor:[UIColor RandomColor]];

  //  [_btnPopNumber setUserInteractionEnabled:NO];

    WEAKSELF
    if (!timer) {
        timer = [[GCDTimer alloc]init];
        
        [timer event:^{
            CGFloat min = rand()%100;
            CGFloat max = rand()%100;
            if (min>max) {
                CGFloat temp = min;
                        min  = max;
                        max  = temp;
            }
            _popNumberAnimation.fromValue = min;
            _popNumberAnimation.toValue   = max;
            _popNumberAnimation.duration  = 10;
            [_popNumberAnimation saveValues];
            [_popNumberAnimation startAnimation];
            
            [GCDQueue executeInMainQueue:^{
                [weakSelf.btnPopNumber setBackgroundColor:[UIColor RandomColor]];
            }];
            
        } timeInterval:13*NSEC_PER_SEC];
        [timer start];
 
    }
    
}
#pragma  mark PopNumberAnimation
-(void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue{
    DLog(@"currentValue = %f",currentValue);
    
    [_btnPopNumber setTitle:[NSString stringWithFormat:@"%.2f",currentValue]  forState:UIControlStateNormal];
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

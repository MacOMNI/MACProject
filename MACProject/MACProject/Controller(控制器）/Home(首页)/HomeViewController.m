//
//  HomeViewController.m
//  MACProject
//
//  Created by MacKun on 16/8/12.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "HomeViewController.h"
#import "CSStickyHeaderFlowLayout.h"
#import "ParallaxHeaderViewCell.h"
#import "NewCarouselListCell.h"
#import "CarLightViewCell.h"
#import "BannerCell.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>{
    CGFloat headerHeight;
}
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"Cell";
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initUI{
    // self.fd_prefersNavigationBarHidden=YES;
    headerHeight                                  = 200;
    self.title                                    = @"闲鱼";
    CSStickyHeaderFlowLayout *flowLayout          = [[CSStickyHeaderFlowLayout alloc]init];
    flowLayout.parallaxHeaderReferenceSize        = CGSizeMake(self.view.width, headerHeight);
    
    flowLayout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.width, 100);
    flowLayout.itemSize                           = CGSizeMake(self.view.width, headerHeight);
    // If we want to disable the sticky header effect
    self.automaticallyAdjustsScrollViewInsets     = NO;//保证从0
    // flowLayout.disableStickyHeaders = NO;
    self.collectionView                           = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, appWidth , appHeight-40) collectionViewLayout:flowLayout];
    //self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    self.collectionView.backgroundColor           = [UIColor whiteColor];
    self.collectionView.dataSource                = self;
    self.collectionView.delegate                  = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[ParallaxHeaderViewCell loadNib]
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"ParallaxHeaderViewCell"];
    [self.collectionView registerNib:[NewCarouselListCell loadNib] forCellWithReuseIdentifier:@"newCarouselListCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:@"bannerCell"];
    [self.collectionView registerNib:[CarLightViewCell loadNib] forCellWithReuseIdentifier:@"carLightViewCell"];
}
-(void)initData{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr   = @[@"newCarouselListCell",@"carLightViewCell" ,@"bannerCell"];
    UICollectionViewCell   *cell = nil;
    if (indexPath.section < arr.count) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:arr[indexPath.section] forIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor RandomColor];
        
    }
    // Configure the cell
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *cell=nil;
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                  withReuseIdentifier:@"ParallaxHeaderViewCell"
                                                         forIndexPath:indexPath];
    }
    return cell;
}
#pragma  mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr   = @[@150.0f,@164.f,@150.0f];
    if (indexPath.section < arr.count) {
        return CGSizeMake(self.view.width, [arr[indexPath.section] floatValue]);
    }
    
    return CGSizeMake(self.view.width, headerHeight);
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = 0;
    if (offsetY >= 64) {
        alpha=((offsetY-64)/64 <= 1.0 ? (offsetY-64)/64:1);
        [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor appNavigationBarColor] colorWithAlphaComponent:alpha]];
        
    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    }
    
}

@end


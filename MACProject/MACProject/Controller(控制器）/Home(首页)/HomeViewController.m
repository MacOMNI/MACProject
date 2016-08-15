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
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>{
    CGFloat headerHeight;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) UINib *headerNib;

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
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initUI{
   // self.fd_prefersNavigationBarHidden=YES;
    headerHeight=200;
    self.title=@"闲鱼";
    CSStickyHeaderFlowLayout *flowLayout=[[CSStickyHeaderFlowLayout alloc]init];
    flowLayout.parallaxHeaderReferenceSize = CGSizeMake(self.view.width, headerHeight);
    
    flowLayout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.width, 100);
    flowLayout.itemSize = CGSizeMake(self.view.width, headerHeight);
    // If we want to disable the sticky header effect
    self.automaticallyAdjustsScrollViewInsets=NO;//保证从0
   // flowLayout.disableStickyHeaders = NO;
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, appWidth , appHeight-40) collectionViewLayout:flowLayout];
    //self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:self.headerNib
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"ParallaxHeaderViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewCarouselListCell" bundle:nil] forCellWithReuseIdentifier:@"newCarouselListCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
-(void)initData{
    
}
-(UINib *)headerNib{
    if (!_headerNib) {
        _headerNib = [UINib nibWithNibName:@"ParallaxHeaderViewCell" bundle:nil];
    }
    return _headerNib;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
           NewCarouselListCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"newCarouselListCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        
        default:{
         UICollectionViewCell   *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            // Configure the cell
            cell.backgroundColor=[UIColor RandomColor];
            return cell;


        }
            break;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *cell=nil;
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"ParallaxHeaderViewCell"
                                                                                   forIndexPath:indexPath];
      //  DLog(@"row %ld section %ld",(long)indexPath.row,(long)indexPath.section);
    }
    return cell;
}
#pragma  mark UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            return CGSizeMake(self.view.width, GTFixHeightFlaot(150.f));
        }
            break;
            
        default:{
            return CGSizeMake(self.view.width, headerHeight);

        }
            break;
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    DLog(@"ScrollView offsetY = %f",offsetY);
    CGFloat alpha=0;
    if (offsetY>=64) {
        alpha=((offsetY-64)/64<=1.0?(offsetY-64)/64:1);
        [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor appNavigationBarColor] colorWithAlphaComponent:alpha]];

    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    }

}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

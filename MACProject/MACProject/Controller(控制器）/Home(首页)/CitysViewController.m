//
//  CitysViewController.m
//  MainProject
//
//  Created by MacKun on 16/5/16.
//  Copyright © 2016年 com.soullon.EnjoyLearning. All rights reserved.
//

#import "CitysViewController.h"
#import "CitysXMLParser.h"
#import "NSString+HLHanZiToPinYin.h"
#import "INTULocationManager.h"
#import "CityModel.h"
#import "SearchCoreManager.h"
#import "ChineseToPinyin.h"
#import "UIButton+Submitting.h"
#import "UIButton+Block.h"

@interface CitysViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    @private
    UILabel *_currentCityLabel;
    UIButton *_currentCityButton;
    BOOL isSearch;
    CitysXMLParser *xmlParser;
    NSMutableArray *arrayIndexs;//索引组
}

@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UITableView *cityTableView;
@property(nonatomic, strong) UIView *headerView;
/**
 *  城市原始数组
 */
@property(nonatomic, strong) NSMutableArray *cityArray;
/**
 *  城市原始字典
 */
@property(nonatomic, strong) NSMutableDictionary *cityDic;
/**
 *  搜索索引ID
 */
@property(nonatomic, strong) NSMutableArray *resultArray;
/**
 *  sectionHeaderTitleAr
 */
@property(nonatomic, strong) NSMutableArray *indexTitleArr;
@end

@implementation CitysViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initData];
    [self.cityTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.cityTableView];
}
-(void)initData{
    [[SearchCoreManager share] Reset];
    xmlParser = [[CitysXMLParser alloc]init];
    [xmlParser start];
    _cityArray = xmlParser.cityArr;
    [self getCityDic];

}
- (NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [[NSMutableArray alloc] init];
    }
    return _resultArray;
}
-(void)getCityDic{
    self.cityDic = [NSMutableDictionary new];

    arrayIndexs = [NSMutableArray array];
    _indexTitleArr = [NSMutableArray array];
    NSDictionary *dic = [NSDictionary new];
    NSString *currentFirstCharactor = @"A";
    NSString *preFirstCharactor = @"A";
    CityModel *model = _cityArray[0];

    [[SearchCoreManager share]addDataList:[NSNumber numberWithInteger:model.CITY_CODE] name:model.CITY_NAME];
    [_cityDic setValue:model.CITY_NAME forKey:[NSString stringWithFormat:@"%ld",(long)model.CITY_CODE]];
    NSInteger currentCount = 1;
    for (NSInteger i=1; i<_cityArray.count; i++) {
        CityModel *currentModel=_cityArray[i];
        [[SearchCoreManager share]addDataList:[NSNumber numberWithInteger:currentModel.CITY_CODE] name:currentModel.CITY_NAME];
        [_cityDic setValue:currentModel.CITY_NAME forKey:[NSString stringWithFormat:@"%ld",(long)currentModel.CITY_CODE]];

        CityModel *preModel = _cityArray[i-1];
        preFirstCharactor = [[ChineseToPinyin pinyinFromChiniseString: preModel.CITY_NAME] substringToIndex:1];
        currentFirstCharactor = [[ChineseToPinyin pinyinFromChiniseString: currentModel.CITY_NAME]substringToIndex:1];
        if ([currentFirstCharactor isEqualToString:preFirstCharactor]) {
            currentCount++;
        }else{
            dic = @{
                    @"sectionCharactor":preFirstCharactor,
                    @"sectionCount":[NSNumber numberWithInteger:currentCount],
                    @"sectionObjectIndex":[NSNumber numberWithInteger:i-currentCount]
                    };
            [arrayIndexs addObject:dic];
            [_indexTitleArr addObject:preFirstCharactor];
            currentCount = 1;
        }
    }
    dic = @{
          @"sectionCharactor":preFirstCharactor,
          @"sectionCount":[NSNumber numberWithInteger:currentCount],
          @"sectionObjectIndex":[NSNumber numberWithInteger:_cityArray.count-currentCount]
          };
    [arrayIndexs addObject:dic];
    [_indexTitleArr addObject:preFirstCharactor];

}

- (UITableView *)cityTableView{
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108.0f, self.view.width, self.view.height-64.0f-44.0f) style:UITableViewStylePlain];
        _cityTableView.dataSource = self;
        _cityTableView.delegate = self;
        _cityTableView.tableFooterView = [UIView new];
        _cityTableView.tableHeaderView = self.headerView;
        _cityTableView.rowHeight = GTFixHeightFlaot(44.0f);
        _cityTableView.sectionIndexColor = [UIColor appRedColor];
    }
    return _cityTableView;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64.0f, self.view.width, 44.0f)];
        _searchBar.placeholder = @"输入城市名或拼音简写";
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = [UIColor appRedColor];
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return _searchBar;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width-15.0f, 85.0f)];
        _currentCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 5.0f, 110.0f, 21.0f)];
        _currentCityLabel.textColor = [UIColor appTitleColor];
        _currentCityLabel.text = @"当前定位城市";
        [_headerView addSubview:_currentCityLabel];
 
        _currentCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _currentCityButton.frame = CGRectMake(8, _currentCityLabel.bottom+8.0f, 110, 44.0f);
        _currentCityButton.layer.masksToBounds = YES;
        _currentCityButton.tag = 1;
        _currentCityButton.layer.cornerRadius = 1.0f;
        _currentCityButton.backgroundColor = [UIColor appGreenColor];
               [_headerView addSubview:_currentCityButton];
        [_currentCityButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        [_currentCityButton  beginSubmitting:@""];

        [self getLocationCity];
        
    }
   
    return _headerView;
}
-(void)btnAction:(id)sender{
    UIButton *btn = sender;
    [self.view showMessage:[@"当前定位城市：" stringByAppendingString:btn.currentTitle] ];
}
-(void)getLocationCity{
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:10 block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {

        if (INTULocationStatusSuccess==status) {
            CLLocationCoordinate2D coord = [currentLocation coordinate];
            CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
            [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                if (error) {
                    DLog("error %@",error.description);
                    [self.view showSuccess:@"暂时无法获取位置信息"];
                }else {
                    for (CLPlacemark *placeMark in placemarks) {
                       // CLRegion *region=placeMark.region;

                        DLog(@"地址name:%@ ",placeMark.name);
                        DLog(@"地址thoroughfare:%@",placeMark.thoroughfare);
                        DLog(@"地址subThoroughfare:%@",placeMark.subThoroughfare);
                        DLog(@"地址locality:%@",placeMark.locality);
                          NSString *city = placeMark.locality;
                        if (!city) {
                            //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                            city = placeMark.administrativeArea;
                        }
                        [_currentCityButton setTitle:city forState:UIControlStateNormal];
                       // [_currentCityButton sizeToFit];

                        DLog(@"地址subLocality:%@",placeMark.subLocality);
                        DLog(@"地址administrativeArea:%@",placeMark.administrativeArea);
                        DLog(@"地址subAdministrativeArea:%@",placeMark.subAdministrativeArea);
                        DLog(@"地址postalCode:%@",placeMark.postalCode);
                        DLog(@"地址ISOcountryCode:%@",placeMark.ISOcountryCode);
                        DLog(@"地址country:%@",placeMark.country);
                        DLog(@"地址inlandWater:%@",placeMark.inlandWater);
                        DLog(@"地址ocean:%@",placeMark.ocean);
                        DLog(@"地址areasOfInterest:%@",placeMark.areasOfInterest);
                    }
                }
            }];

            DLog(@"经度:%f,纬度:%f",coord.latitude,coord.longitude);

        }else  {
            [self.view showSuccess:@"获取地理位置失败"];
        }
        [_currentCityButton endSubmitting];

    }];

}
#pragma mark - tableView
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!isSearch) {
         return _indexTitleArr;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!isSearch) {
        return [_indexTitleArr count];
    }
    
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (!isSearch) {
        return _indexTitleArr[section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!isSearch) {
//        dic=@{
//              @"sectionCharactor":preFirstCharactor,
//              @"sectionCount":[NSNumber numberWithInteger:currentCount],
//              @"sectionObjectIndex":[NSNumber numberWithInteger:i-currentCount]
//              };
//        [arrayIndexs addObject:];
        NSDictionary *dic=arrayIndexs[section];
        return [[dic objectForKey:@"sectionCount"] integerValue];
    }
    return [self.resultArray count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 44.0f;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cityIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    }
    
    if (!isSearch) {
        NSDictionary *dic = arrayIndexs[indexPath.section];
        NSInteger index  = [[dic objectForKey:@"sectionObjectIndex"] integerValue]+indexPath.row;
        CityModel *model = self.cityArray[index];
        cell.textLabel.text = model.CITY_NAME;

    }else{
        NSInteger city_code = [self.resultArray[indexPath.row] integerValue];
        NSString *city = [self.cityDic objectForKey:[NSString stringWithFormat:@"%ld",(long)city_code]];
         cell.textLabel.text = city;
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSString *city = cell.textLabel.text;
//    NSString *code=@"";
//    if (isSearch) {
//        code=[NSString stringWithFormat:@"%d",[self.resultArray[indexPath.row] integerValue]];
//    }else{
//        NSDictionary *dic=arrayIndexs[indexPath.section];
//        NSInteger index=[[dic objectForKey:@"sectionObjectIndex"] integerValue]+indexPath.row;
//        CityModel *model=self.cityArray[index];
//        code=[NSString stringWithFormat:@"%d",model.CITY_CODE];
//    }
       // [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - searchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    isSearch = YES;
    self.cityTableView.tableHeaderView = nil;
    [self.cityTableView reloadData];
    searchBar.showsCancelButton = YES;
}
- (void)searchBar:(UISearchBar *)_searchBar textDidChange:(NSString *)searchText
{
    self.resultArray=[NSMutableArray array];
    [[SearchCoreManager share]Search:searchText searchArray:nil nameMatch:self.resultArray];
    [self.cityTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    self.resultArray=[NSMutableArray array];

    [[SearchCoreManager share]Search:searchBar.text searchArray:nil nameMatch:self.resultArray];

    if ([self.resultArray count] == 0) {
        [self.view showSuccess:@"没有找到您搜索的城市"];
    }
    [self.cityTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    isSearch = NO;
    self.cityTableView.tableHeaderView = self.headerView;

    searchBar.text = nil;
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    
    [self.cityTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigatio

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

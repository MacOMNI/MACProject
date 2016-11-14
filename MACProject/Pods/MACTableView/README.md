# MACTableView
##Projects using this library

对 UITableView 空白页文字提示、空白页图片、上拉下拉事件等进行了高度封装，使用简单高效，并命名为MACTableView, 欢迎star & issue

![GIF 1](https://github.com/azheng51714/MACTableView/blob/master/Photos/fvyO81OO7L.gif)
![GIF 2](https://github.com/azheng51714/MACTableView/blob/master/Photos/hmD0r7fU0J.gif)
![GIF 3](https://github.com/azheng51714/MACTableView/blob/master/Photos/MACTableView.png)
### Features
* 支持 多种空白样式：包括是否显示主标题、副标题、空白图以及是否支持上拉下拉代理事件等；
* 基于 MJRefresh & DZNEmptyDataSet 集成设计；
* 支持 Storyboard & Xib;
* 支持 iOS 6 及以上;
* 支持 iPhone & iPad.

## Installation

### cocoapods
```ruby
 pod 'MACTableView', '~> 1.0.0'
```

### Import
导入相关头文件
```objc
#import "MACTableView.h"
```

## How to use
* First Step 初始化 MACTableView ；

```objc
@interface ViewController ()<MACTableViewDelegate>{

}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // self.tableView =  [[MACTableView alloc] initWithFrame:self.view.bounds]; 
    self.tableView.macTableViewDelegate = self;
}
```
* Second Step 设置 MACTableView属性 并开始加载；

```objc
-(void)setUp{
    _tableView.emptyImage = self.emptyImage;
    _tableView.emptyColor = self.emptyColor;
    _tableView.emptyAtrtibutedTitle = self.emptyTitle;
    _tableView.emptyAtrtibutedSubtitle = self.descriptionTitle;
    [_tableView beginLoading];
  } 
```

* Final Step 处理上拉下拉代理事件

```objc
#pragma mark MACTableViewDelegate
-(void)loadDataRefreshOrPull:(MACRefreshState)state{
   if(state == MACRefreshing){//下拉刷新
     //do something
   }else {//加载更多
     // do other thing
   }
  //异步(网络访问)请求后执行 [self.tableView endLoading] 结束刷新
}

```
* Additional Remark 对于有自定义 RefreshHeader 需求的，新建一个继承自 MACRefreshGifHeader 的类，设置相关属性，重写 load 方法即可
  
```objc
-(void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 隐藏时间
    //self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏刷新状态
    //self.stateLabel.hidden = YES;
}

+ (void)load{
    NSLog(@"重写 load 方法， 注册 MACRefreshGifHeader,即可实现自定义RefreshHeader,无需其他操作");
    [super registerMACRefresh];
}
```
![GIF 4](https://github.com/azheng51714/MACTableView/blob/master/Photos/kF4saP4ilk.gif)
![GIF 5](https://github.com/azheng51714/MACTableView/blob/master/Photos/zUsnur8eFq.gif)

### MACTableView

这里对相关的参数变量、枚举类型、代理以及执行方法进行了详细的说明，您只需要根据具体情况设置相关属性，执行相应操作即可。
```objc
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MACRefreshState) {
    
    MACRefreshing = 0, /** 下拉刷新的状态 */
    MACPulling,        /** pull 加载更多刷新中的状态 */
};

typedef NS_ENUM(NSInteger,MACCanLoadState){
    
    MACCanLoadNone = 0,/**不支持下拉和加载更多*/
    MACCanLoadRefresh, /**只支持下拉刷新*/
    MACCanLoadAll,     /** 同时支持下拉和加载更多*/
};

@protocol MACTableViewDelegate <NSObject>

@optional

/**@param state MACRefreshing 下拉刷新 MACPulling 为 Pull 加载更多*/
-(void)loadDataRefreshOrPull:(MACRefreshState)state;

@end

@interface MACTableView : UITableView<NSCoding>

@property (nonatomic,weak) id<MACTableViewDelegate> macTableViewDelegate;//MACTableView delegate

/** 是否展示空白页 默认为YES*/
@property(nonatomic,assign,getter = isShowEmpty)BOOL showEmpty;
/** MACTableView 加载支持，默认同时支持下拉和加载更多*/
@property (nonatomic,assign) IBInspectable MACCanLoadState macCanLoadState;
/**空白页的标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptyTitle;
/**  空白页的副标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptySubtitle;
/**  空白页展位图名称 默认为 nil,不显示*/
@property(nonatomic,strong) IBInspectable UIImage *emptyImage;
/**  空白页背景颜色,默认白色*/
@property(nonatomic,strong) IBInspectable UIColor *emptyColor;

/**空白页的标题 默认为 nil ,不显示*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedTitle;
/**  空白页的副标题 默认为 nil,不显示*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedSubtitle;

/** 获取当下访问接口Page下标 默认从1开始 以来代替控制器计算Page*/
-(NSNumber *)getCurrentPage;
/** 开始加载*/
-(void)beginLoading;
/**结束加载，并刷新数据*/
-(void)endLoading;
/**提示无更多数据*/
-(void)noMoreData;
@end

```
## License
(The MIT License)



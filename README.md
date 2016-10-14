#MACProject
传送门：https://github.com/azheng51714/MACProject
>这是使用 Objective-C 整理的一套 iOS 轻量级框架，内部包含大量或自己整理或修改自网络的 Category 、Utils、DataManager、Macros & UIComponents 旨在快速构建中小型 iOS App，并尝试用其整理了个 MACProject 样例以来抛砖引玉，愿与大犇们相互学习交流，不足之处望批评指正， 更欢迎 Star。

##目录结构

>基于MVC：对常用控件、常用扩展类、数据缓存、网络请求、工具类、常用动画进行封装或二次封装；

![图片](http://upload-images.jianshu.io/upload_images/335970-d8e4adf25d641f3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 这里对几个常用控件源代码进行简单的说明：
基于AF网络请求库的二次封装，并对返回的状态码进行了说明，根据状态码即可知道访问请求结果。
并且接口类型多样，包括 是否缓存访问接口数据、是否带有 网络提示、是否带有文件参数等；

```Objective-C

 #import <Foundation/Foundation.h>
/**
 *  HTTP访问回调
 *
 *  @param urlString 状态码 0 访问失败   200 正常  500 空 其他异常
 *  @param result    返回数据 nil 为空
 *  @param error     错误描述
 */
typedef void(^ResultBlock)(NSInteger stateCode, NSMutableArray* result, NSError *error);
//block不是self的属性或者变量时，在block内使用self也不会循环引用：

@interface BaseService : NSObject

/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
+ (void)POST:(NSString *)URLString  parameters:(id)parameters result:(ResultBlock)requestBlock;
/**
 *  普通的访问请求(无提示，不带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
+ (void)POSTWithNormal:(NSString *)URLString  parameters:(id)parameters result:(ResultBlock)requestBlock;

/**
 *  访问请求(有提示带缓存，带判断网络状态)
 *
 *  @param URLString    请求地址
 *  @param parameters   请求参数
 *  @param requestBlock 请求回调
 */
+ (void)POSTWithCache:(NSString *)URLString parameters:(id)parameters  completionBlock:(ResultBlock)requestBlock;

/**
 *  无提示的访问请求(带缓存，带判断网络状态)
 *
 *  @param URLString    请求地址
 *  @param parameters   请求参数
 *  @param requestBlock 请求回调
 */
+(void)POSTWithCacheNormal:(NSString *)URLString parameters:(id)parameters  completionBlock:(ResultBlock)requestBlock cacheBlock:(ResultBlock)cacheBlock;
/**
 *  上传多媒体文件接口
 *
 *  @param URLString    请求地址
 *  @param parameters   请求参数
 *  @param mediaDatas   多媒体数据  图片传 UIImage  语音传url字符串地址
 *  @param requestBlock 请求回调
 */
+(void)POSTWithFormDataURL:(NSString *)URLString parameters:(id)parameters mediaData:(NSMutableArray *)mediaDatas completionBlock:(ResultBlock)requestBlock;

```
同是对 UITableView 空白页文字、空白页图片、上拉下拉事件等进行了高度集成，命名为MacTableView:

```Objective-C
typedef NS_ENUM(NSInteger, MACRefreshState) {

    /** 下拉刷新的状态 */
    MACRefreshing,
    /** pull刷新中的状态 */
    MACPulling,
};

@protocol MACTableViewDelegate <NSObject>

@optional

/**
 *  获取数据
 *
 *  @param state MACRefreshing为Refresh MACPulling 为 Pull
 */
-(void)loadDataRefreshOrPull:(MACRefreshState)state;

@end

@interface MACTableView : UITableView<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
/**
 *  macTableView delegate
 */
@property (nonatomic,weak) id<MACTableViewDelegate> macTableViewDelegate;
/**
 *  是否支持下拉刷新 默认为YES
 */
@property (nonatomic,assign) BOOL isRefresh;
/**
 *  是否可以加载更多 默认为YES
 */
@property (nonatomic,assign) BOOL isLoadMore;
/**
 *  当前访问的page 下标
 */
@property (nonatomic,assign) NSInteger page;

/**
 *  是否展示空白页 默认为YES
 */
@property(nonatomic,assign)BOOL isShowEmpty;


/**
 *  空白页的标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *titleForEmpty;
/**
 *  空白页的副标题 默认为 “" 为空不显示
 */
@property(nonatomic,copy) NSString *descriptionForEmpty;
/**
 *  空白页展位图名称 默认为 “img_placehoder_icon" 为空或nil无图片
 */
@property(nonatomic,copy) NSString *imageNameForEmpty;

/**
 *  CellDataAdapter arr 暂未 用到
 */
@property(nonatomic,strong) NSMutableArray *cellDataArr;

/**
 *
 *  获取当下访问接口下标
 */
-(NSNumber *)getCurrentPage;
/**
 *  开始加载
 */
-(void)beginLoading;
/**
 *  结束刷新
 */
-(void)endLoading;
///**
// *  提示无更多数据
// */
//-(void)noMoreData;
@end

```
##首页

###仿闲鱼同城界面：

>GCD、CollectionView、Xib 约束、Frame 约束、AutoLayout 代码约束简单应用，抛砖引玉；

![图片](https://github.com/azheng51714/MACProject/blob/master/pic/homePage.gif)

###城市模糊查询：

>定位 、 KMP & SearchTree 搜索实现快速数据检索 与 系统匹配不一样的感受；

![image](https://github.com/azheng51714/MACProject/blob/master/pic/citySearch.gif)

##朋友圈

###仿QQ通信录：

>高仿QQ聊天通讯录，人员分组：

![图片](https://github.com/azheng51714/MACProject/blob/master/pic/QQgroup.gif)

### 高仿朋友圈 & QQ空间
![图片](https://github.com/azheng51714/MACProject/blob/master/pic/friends.gif)


##云周边（暂未开放）

##发现（动画&控件）

![图片](http://oc4tpefat.bkt.clouddn.com/finder.png)




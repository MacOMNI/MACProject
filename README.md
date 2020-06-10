#MACProject
传送门：https://github.com/azheng51714/MACProject

这是使用 Objective-C 整理的一套 iOS 轻量级框架，内部包含大量或自己整理或修改自网络的 Category 、Utils、DataManager、Macros & UIComponents 旨在快速构建中小型 iOS App，并尝试用其整理了个 MACProject 样例以来抛砖引玉，愿与大犇们相互学习交流，不足之处望批评指正， 更欢迎 Star。

##目录结构

基于MVC：对常用控件、常用扩展类、数据缓存、网络请求、工具类、常用动画进行封装或二次封装；

1. 对包括 UIImageView、UILabel、UIButton、UINavgationBar、UINavgationController、UITableView、UITextView、UISearchBar、UIViewController 等在内的常用控件及其扩展类进行了整理，其中对常用的数据加载、提示语、AlertView、sheetView也进行了一键集成；

2. 对包括 NSData、NSDate、NSString、NSArray、NSDictionary、NSNumber、NSObject 等数据类型常用的转换或解析方法进行了整理；

3. 对包括 NSBundle、NSFile、NSFileManger 等数据读取或操作的常用方法行了整理；

4. 对 UIFont、UIColor、UIImage、UIApplication、NSTimer 等也进行了分类整理，保证相关操作简洁高效，常用方法一键实现；
5. 对数据下载(DownLoadManager)、网络请求(BaseService)、GCD、Animation、UserAuth 等也行了简洁的封装。

![图片](http://upload-images.jianshu.io/upload_images/335970-d8e4adf25d641f3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 这里对几个常用控件源代码进行简单的说明：
基于AF网络请求库的二次封装，根据状态码递归解析请求的加密数据；接口类型包括： 普通访问接口、带数据缓存接口、带有网络提示、带有上传文件等；

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
同时对 UITableView 空白页文字、空白页图片、上拉下拉事件等进行了高度封装，命名为MACTableView，使用简单高效,最新版传送门：
https://github.com/azheng51714/MACTableView

##首页

###仿闲鱼同城界面：

GCD、CollectionView、Xib 约束、Frame 约束、AutoLayout 代码约束简单应用，抛砖引玉；

![图片](https://github.com/azheng51714/MACProject/blob/master/pic/homePage.gif)

###城市模糊查询：

定位 、 KMP & SearchTree 搜索实现快速数据检索 与 系统匹配不一样的感受；

![image](https://github.com/azheng51714/MACProject/blob/master/pic/citySearch.gif)

##朋友圈

###仿QQ通信录：

高仿QQ聊天通讯录，人员分组：

![图片](https://github.com/azheng51714/MACProject/blob/master/pic/QQgroup.gif)

### 高仿朋友圈 & QQ空间
![图片](https://github.com/MacOMNI/MACProject/blob/master/pic/friends.gif)

### 我的消息
![图片](https://github.com/azheng51714/MACProject/blob/master/pic/message.png)

##云周边（暂未开放）

##发现（动画&控件）

![图片](http://oc4tpefat.bkt.clouddn.com/finder.png)
### 加载 Logo 动画 loadingView
![加载loadView ](https://github.com/MacOMNI/MACProject/blob/master/pic/loadingView.gif)
### 加载 波浪 动画 MACWaveView
![加载MACWaveView ](https://github.com/azheng51714/MACProject/blob/master/pic/MACWaveView.gif)
### 基础 ChartView
![加载MACWaveView ](https://github.com/azheng51714/MACProject/blob/master/pic/chartView.png)



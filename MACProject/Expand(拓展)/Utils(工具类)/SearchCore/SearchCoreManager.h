/*
 ============================================================================
 Name		: SearchCore.h
 Author	  : SearchCore
 Version	 : 1.0
 Description : CSearchCore declaration
 ============================================================================
 */


// CLASS DECLARATION
#include "SearchCore.h"

#define KSeparateWord '/'
#define KStringNull @""

@interface SearchCoreManager :NSObject{
    SearchTree iSearchTree;
    NSString *separateWord;
    NSString *matchFunction;
}

+ (SearchCoreManager*)share;

/*
 添加联系人到搜索
 localID:联系人ID
 name:名字
 phone:号码数组
 */
- (void)AddContact:(NSNumber*)localID name:(NSString*)name phone:(NSArray*)phoneArray;


/**
 *  添加数据列表
 *
 *  @param localID KeyID
 *  @param name    学习名称
 */
-(void)addDataList:(NSNumber*)localID name:(NSString *)name;

/*
 联系人变动，替换搜索中的数据
 localID:联系人ID
 name:名字
 phonePre:联系人修改前的号码数组
 phoneNow:联系人修改后的号码数组
 */
- (void)ReplaceContact:(NSNumber*)localID name:(NSString*)name phone:(NSArray*)phoneArray;

/*
 删除搜索中的联系人数据
 localID:联系人ID
 phone:联系人删除前的号码数组
 */
- (void)DeleteContact:(NSNumber*)localID;

/*
 搜索联系人,优先姓名匹配，姓名、号码匹配数据不重复
 searchText:搜索串
 searchArray:设定搜索的联系人ID,如果为nil表示搜索所有缓存中的联系人(若是搜索所有的，建议参数为nil，比较快)
 nameMatch:返回值——搜索后符合姓名匹配的联系人ID数组
 phoneMatch:返回值——搜索后符合号码匹配的联系人ID数组
 */
- (void)Search:(NSString*)searchText searchArray:(NSArray*)aSearchedArray nameMatch:(NSMutableArray*)nameMatchArray phoneMatch:(NSMutableArray*)phoneMatchArray;


-(NSMutableArray *)Search:(NSString*)searchText;

/*
 搜索联系人,优先姓名匹配，姓名、号码匹配数据不重复
 searchText:搜索串
 searchArray:设定搜索的联系人ID,如果为nil表示搜索所有缓存中的联系人(若是搜索所有的，建议参数为nil，比较快)
 nameMatch:返回值——搜索后符合姓名匹配的联系人ID数组
 */
- (void)Search:(NSString*)searchText searchArray:(NSArray*)aSearchedArray nameMatch:(NSMutableArray*)nameMatchArray;


/*
 搜索联系人,优先姓名匹配，姓名、号码匹配数据不重复
 matchFunc:输入与26个字母对应字符的串，比如T9键盘为22233344455566677778889999
 其他参数同上
 */
- (void)SearchWithFunc:(NSString*)matchFunc searchText:(NSString*)searchText searchArray:(NSArray*)aSearchedArray nameMatch:(NSMutableArray*)nameMatchArray phoneMatch:(NSMutableArray*)phoneMatchArray;

/*
 获取姓名匹配的人的拼音，及匹配位置
 localID:姓名匹配的联系人ID
 pinYin:返回值-拼音串
 matchPos:拼音的匹配位置
 */
- (BOOL)GetPinYin:(NSNumber*)localID pinYin:(NSMutableString*)pinyinDes matchPos:(NSMutableArray*)matchPosInPinYin;

/*
 获取号码匹配的人的所有匹配号码，及匹配位置
 localID:号码匹配的联系人ID
 phone:返回值-所有匹配的号码
 matchPos:号码对应的匹配位置
 */
- (BOOL)GetPhoneNum:(NSNumber*)localID phone:(NSMutableArray*)phoneArray matchPos:(NSMutableArray*)matchPosArray;

/*
 重置搜索——清空搜索缓存
 */
- (void)Reset;


@end

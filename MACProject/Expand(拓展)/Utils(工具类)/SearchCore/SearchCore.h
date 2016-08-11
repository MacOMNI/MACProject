/*
 ===================================================================
 Author: SearchCore


供外部调用的函数：
void SearchTreeInit 
void Tree_SetMatchFunction

void FreeSearchTree
void ReleaseMultiPYinWords

void Tree_AddData
void Tree_ReplaceData
void Tree_DeleteData

void Tree_Search

BOOL Tree_GetPinYin
BOOL Tree_GetPhoneNum
 ====================================================================
 */

#ifndef SearchCore_H
#define SearchCore_H

#include "Array.h"
#include "string.h"


//typedef int BOOL;
typedef unsigned short u2char;
#define TRUE 1
#define FALSE 0

#define KLetterNum 26                                       // 英文字母 个数 
#define KDignitalNum 10                                     //数字个数
#define KPyCodeNum 406                                      // 拼音码表个数
#define KRomeCodeNum 94                                     // 罗马数字码表个数 
#define KGreeceCodeNum 24                                   // 希腊字母码表个数
#define KMaxPyCode 5                                        // 每个字最多可能具有的拼音码个数
#define KSearchPosMalloc 126                                // SearchPos每次分配的个数

#define KCachedHitNonAlpha (KLetterNum+KDignitalNum)        // 非英文字母、数字搜索缓存集
#define KCachedHitFull (KCachedHitNonAlpha+1)               // 全搜索缓存集
#define KCachedHitNum (KLetterNum+KDignitalNum+2)           // 搜索缓存集个数(26个英文字母+非英文字符+全搜索集)



typedef struct WordCode
{
u2char Word;                                                //原始unicode码
int PyCodeNum;                                              // 拼音码个数
int* PyCodeIndex;                                           // 拼音码值（支持多拼音）

}WordCode;

typedef struct SearchData
{
	long id;                                                 //唯一标志ID
	u2char* iPhoneNum;                                      //电话号码，用于号码匹配
	
    int WordCodeNum;
	u2char *WordCodeArray;
}SearchData;

typedef struct SearchPos
{
	int pos;                                                //(第几个字：18bit) + (第几个拼音码：3bit) + (第几个字母：3bit)
	int step;                                               //步长:当前匹配到第几个字

	struct SearchPos * iFather;                             //father
}SearchPos;


typedef struct SearchTree
{	  
	struct Array SearchDataArray;                           //SearchData缓存
	struct Array iCachedHits[KCachedHitNum];                //汉字的拼音的首字母缓存
	struct SearchData *iCurSeachData;                       //当前输入转换的搜索串
	struct Array iMatchTrace;                               //当前匹配路径

	u2char* iMatchFunc;                                     //键盘字母与数字的对应关系

}SearchTree;

typedef struct SearchSort
{
    SearchData *data;
    bool matchAllInPy;                                      //全拼音匹配
    bool matchAllInWord;                                    //全汉字匹配
    int matchStart;                                         //匹配首位置
    int matchEnd;                                           //匹配末位置
    u2char* iSortString;                                    //用于ASCII排序
}SearchSort;
//==============================================  BEGIN  ================================================
//供外部调用的函数
int u2slen(const u2char* str);
void u2scpy(u2char* des,const u2char* src);
int u2scmp(const u2char* str1,const u2char* str2);

//搜索初始化
void SearchTreeInit(SearchTree* tree);

// 加载多音字
void LoadMultiPYinWords(const char* multiPYinPath);

/*
 * 释放搜索树
 */
void FreeSearchTree(SearchTree* tree);

/*
 * 释放搜索系统资源  释放多音字资源
 */
void ReleaseMultiPYinWords();


/*
 * 添加数据源信息
 * aID: 数据索引ID
 * aText: 名字
 * aPhoneNum：号码
 */
void Tree_AddData(SearchTree* tree, long aID, const u2char* aText,const u2char* aPhoneNum);

/*
 * 修改数据源信息
 * aID: 数据索引ID
 * aText: 名字
 * aPhoneNum：号码
 */
void Tree_ReplaceData(SearchTree* tree, long aID, const u2char* aText,const u2char* aPhoneNum );

/*
 * 删除数据源信息
 * aID: 数据索引ID
 */
void Tree_DeleteData(SearchTree* tree, long aID );

/*
 * 搜索数据
 * aText: 搜索串
 * aSearchedArray 搜索域，输入NULL时搜索tree中的联系人
 * aNameMatchArray: 名字搜索结果
 * aPhoneMatchArray：号码搜索结果
 * sortByMatchValue：按搜索位置排序
 */
void Tree_Search(SearchTree* tree, u2char* aText, Array* aSearchedArray,Array* aNameMatchArray, Array* aPhoneMatchArray);

//键盘26个字母与数字的对应
void Tree_SetMatchFunction(SearchTree* tree,const u2char* aMatchFunc);

/*
 * 获取名字匹配的拼音、匹配位置
 * aID 索引ID
 * aText 拼音
 * iMatchPosInPinYin 匹配位置
 */
BOOL Tree_GetPinYin(SearchTree* tree,long aID, u2char* aText, Array* iMatchPosInPinYin);

/*
 * 获取号码匹配的号码、匹配位置
 */
BOOL Tree_GetPhoneNum(SearchTree* tree,long aID, u2char* aText, Array* iMatchPosInPhoneNum);


//================================================  END  ==============================================










void SortPinYinCodeIndex();

/*
 * 添加到缓存的搜索集
 */
void AddToCachedHit(SearchTree* tree,SearchData *aData);

void AddToCachedHitSingle(SearchTree* tree,SearchData *aData, Array* aCacheArray);

//kmp匹配 适用于查找连续字串——号码
BOOL IsMatchByKmp(const u2char* aText,const u2char* wordInput,Array* iMatchPosInPinYin);

//aID 的索引index  < 0为不存在
int FindSearchDataIndex(Array* ptr,long aID,SearchData** data);

/*
 * < 0 已存在
 * > 0 需插入位置
 */
int FindSearchDataInsertIndex(Array* ptr,long aID);

/*
 *	aText GBK编码
 */
void Text2SearchData(const u2char* aText,SearchData *data);

BOOL Word2Code(u2char aWord,WordCode *code );

BOOL SearchCachedHit(SearchTree* tree, u2char word, Array **aHits);

/*
 * 确定某一搜索集是否匹配搜索串  return匹配的权值,<0为不匹配
 */
int IsHit(SearchTree* tree,SearchData* aData, SearchData* aSearchWordData,BOOL iIsLogTrace);

/*
 * 确定aWordCode串的aPos位置，是否和aWord相匹配
 */
BOOL IsMatch(SearchTree* tree,WordCode* aWordCode,int nPyCode,int nchar, unsigned int aWord );

unsigned int ChangeWordToDigit(SearchTree* tree,unsigned int Word);

BOOL CompareWord(SearchTree* tree,unsigned int Word,unsigned int WordInput);

int FindIndexInMultiPYin(unsigned int key);

SearchPos* GetSearchPos(int index);

void FreeWordCode(WordCode* word);
void FreeSearchData(SearchData* data);
void FreeSearchPos(SearchPos* data);


#endif


/*
 ============================================================================
 Name		: SearchCore.cpp
 Author	  : SearchCore
 Version	 : 1.0
 Description : CSearchCore implementation
 ============================================================================
 */

#include "SearchCoreManager.h"

static SearchCoreManager *searchCoreManager = nil;

@implementation SearchCoreManager
+ (SearchCoreManager *)share {
    if (!searchCoreManager) {
        searchCoreManager = [[SearchCoreManager alloc] init];
    }
    return searchCoreManager;
}



- (id)init {
    if (self = [super init]) {
        SearchTreeInit(&iSearchTree);
        NSString *multiPYinpath = [[NSBundle mainBundle] pathForResource:@"multipy_unicode" ofType:@"dat"];
        LoadMultiPYinWords([multiPYinpath UTF8String]);
        separateWord = [NSString stringWithFormat:@"%c",KSeparateWord];
    }
    return self;
}

- (void)SetMatchFunction:(NSString*) matchFunc {
    if (matchFunction==matchFunc || [matchFunction isEqualToString:matchFunc]) {
        return;
    }
    if (matchFunction) {
        matchFunction=nil;
    }
    matchFunction = @"";
    
    
	u2char buf[256];
	[self string_u2char:matchFunc u2char:buf];
	
	Tree_SetMatchFunction(&iSearchTree,buf);
}

//string 转 u2char
- (void)string_u2char:(NSString*)src u2char:(u2char*)des {
    u2char* ptr = des;
    for (int i = 0; i < [src length]; i ++) {
        unichar word = [src characterAtIndex:i];
        *ptr = word;
        ptr ++;
    }
    *ptr = 0;
}

//Array 转 NSArray
- (void)ArrayToNSArray:(Array*)array NSArray:(NSMutableArray*)arrayDes {
    [arrayDes removeAllObjects];
    
    for (int i = 0; i < array->size; i ++) {
        long aID = (long)array->GetValue(array,i);
        [arrayDes addObject:[NSNumber numberWithLong:aID]];
    }
}


-(void)addDataList:(NSNumber*)localID name:(NSString *)name
{
    NSMutableString *str = [[NSMutableString alloc] init];

    u2char nameBuf[name.length + 1];
    [self string_u2char:name u2char:nameBuf];
    u2char phoneBuf[str.length + 1];
    [self string_u2char:str u2char:phoneBuf];
    
    Tree_AddData(&iSearchTree,[localID longValue],nameBuf,phoneBuf);
}


- (void)AddContact:(NSNumber*)localID name:(NSString*)name phone:(NSArray*)phoneArray {
    //将联系人的号码用分隔符拼接添加到搜索,不直接用Array,为了优化号码搜索(KMP复杂度M+N)
    
    NSMutableString *phoneStr = [[NSMutableString alloc] init];
    for (int i = 0; i < [phoneArray count]; i ++) {
        NSString *phone = [phoneArray objectAtIndex:i];
        [phoneStr appendString:phone];
        [phoneStr appendString:separateWord];
    }
    
    u2char nameBuf[name.length + 1];
    [self string_u2char:name u2char:nameBuf];
    
    u2char phoneBuf[phoneStr.length + 1];
    [self string_u2char:phoneStr u2char:phoneBuf];
    
    Tree_AddData(&iSearchTree,[localID longValue],nameBuf,phoneBuf);
    
}

- (void)ReplaceContact:(NSNumber*)localID name:(NSString*)name phone:(NSArray*)phoneArray {
    
    NSMutableString *phoneStr = [[NSMutableString alloc] init];
    for (int i = 0; i < [phoneArray count]; i ++) {
        NSString *phone = [phoneArray objectAtIndex:i];
        [phoneStr appendString:phone];
        [phoneStr appendString:separateWord];
    }
    
    u2char nameBuf[name.length + 1];
    [self string_u2char:name u2char:nameBuf];
    
    u2char phoneBuf[phoneStr.length + 1];
    [self string_u2char:phoneStr u2char:phoneBuf];
    
    Tree_ReplaceData(&iSearchTree,[localID longValue],nameBuf,phoneBuf);

}

- (void)DeleteContact:(NSNumber*)localID {
	Tree_DeleteData(&iSearchTree,[localID longValue]);
}
- (void)Search:(NSString*)searchText searchArray:(NSArray*)aSearchedArray nameMatch:(NSMutableArray*)nameMatchArray
{
    [self SetMatchFunction:KStringNull];
    NSMutableArray *phoneMatchArray=[NSMutableArray array];
    [self SearchDefault:searchText searchArray:aSearchedArray nameMatch:nameMatchArray phoneMatch:phoneMatchArray];
}
- (void)SearchDefault:(NSString*)searchText searchArray:(NSArray*)aSearchedArray nameMatch:(NSMutableArray*)nameMatchArray phoneMatch:(NSMutableArray*)phoneMatchArray {
    
    u2char searchTextBuf[searchText.length + 1];
    [self string_u2char:searchText u2char:searchTextBuf];
    
    Array* searchedArray = NULL;
	Array* nameMatchHits = NULL;
	Array* phoneMatchHits = NULL;
	if (aSearchedArray) {
		searchedArray = new Array;
		ArrayInit(searchedArray);
        
        for (int i = 0; i < [aSearchedArray count]; i ++) {
            NSNumber *number = [aSearchedArray objectAtIndex:i];
            searchedArray->Append(searchedArray,[number longValue]);
        }
    }
	
	if (nameMatchArray) {
        [nameMatchArray removeAllObjects];
        
		nameMatchHits = new Array;
		ArrayInit(nameMatchHits);
    }
	
	if (phoneMatchArray) {
        [phoneMatchArray removeAllObjects];
        
		phoneMatchHits = new Array;
		ArrayInit(phoneMatchHits);
    }
	
	Tree_Search(&iSearchTree,searchTextBuf,searchedArray,nameMatchHits,phoneMatchHits);
	
	if (nameMatchHits) {
        [self ArrayToNSArray:nameMatchHits NSArray:nameMatchArray];
		nameMatchHits->Reset(nameMatchHits);
		delete nameMatchHits;
    }
	
	if (phoneMatchHits) {
        [self ArrayToNSArray:phoneMatchHits NSArray:phoneMatchArray];
		phoneMatchHits->Reset(phoneMatchHits);
		delete phoneMatchHits;
    }
	
	if (searchedArray) {
		searchedArray->Reset(searchedArray);
		delete searchedArray;
    }
    
}
-(NSMutableArray *)Search:(NSString *)searchText{
    NSMutableArray *arr=[NSMutableArray array];
    
    return arr;
}
//搜索 MatchFunction为空
- (void)Search:(NSString*)searchText searchArray:(NSArray*)aSearchedArray nameMatch:(NSMutableArray*)nameMatchArray phoneMatch:(NSMutableArray*)phoneMatchArray {
    [self SetMatchFunction:KStringNull];
    [self SearchDefault:searchText searchArray:aSearchedArray nameMatch:nameMatchArray phoneMatch:phoneMatchArray];
}

//搜索 带MatchFunction
- (void)SearchWithFunc:(NSString*)matchFunc searchText:(NSString*)searchText searchArray:(NSArray*)aSearchedArray nameMatch:(NSMutableArray*)nameMatchArray phoneMatch:(NSMutableArray*)phoneMatchArray {
    [self SetMatchFunction:matchFunc];
    [self SearchDefault:searchText searchArray:aSearchedArray nameMatch:nameMatchArray phoneMatch:phoneMatchArray];
}
- (BOOL)GetPinYin:(NSNumber*)localID pinYin:(NSMutableString*)pinyinDes matchPos:(NSMutableArray*)matchPosInPinYin {
    [pinyinDes setString:@""];

    u2char pinyinBuf[256];
    
    Array* aMatchPosInPinYin = NULL;
	if (matchPosInPinYin ) {
		aMatchPosInPinYin = new Array;
		ArrayInit(aMatchPosInPinYin);
    }
	
	BOOL result = Tree_GetPinYin(&iSearchTree,[localID longValue],pinyinBuf,aMatchPosInPinYin);
    
    int length = u2slen(pinyinBuf);
    [pinyinDes appendString:[NSString stringWithCharacters:(unichar*)pinyinBuf length:length]];
	
	if (aMatchPosInPinYin) {
        [self ArrayToNSArray:aMatchPosInPinYin NSArray:matchPosInPinYin];
        aMatchPosInPinYin->Reset(aMatchPosInPinYin);
		delete aMatchPosInPinYin;
    }
	
	return result;
}

//用分隔符拼接的号码，转换到原有的样式，提取匹配的号码及匹配位置
- (void) ChangeToOranagePhones:(NSString*)phones matchPos:(NSArray*)matchPos phoneArray:(NSMutableArray*)phoneArray matchPosArray:(NSMutableArray*)matchPosArray {
    
    int start = [[matchPos objectAtIndex:0] intValue];
    while (start >= 0) {
        unichar word = [phones characterAtIndex:start];
        if (word == KSeparateWord) {
            break;
        }
        start --;
    }
    start ++;
    
    int end = [[matchPos objectAtIndex:matchPos.count-1] intValue];
    while (end < [phones length]) {
        unichar word = [phones characterAtIndex:end];
        if (word == KSeparateWord) {
            break;
        }
        end ++;
    }
    NSRange range = NSMakeRange(start, end - start);
    NSString *phone = [phones substringWithRange:range];
    
    NSMutableArray *matchPosDes = [[NSMutableArray alloc] init];
    for (int i = 0; i < [matchPos count]; i ++) {
        int pos = [[matchPos objectAtIndex:i] intValue];
        pos -= start;
        [matchPosDes addObject:[NSNumber numberWithInt:pos]];
    }
    [phoneArray addObject:phone];
    [matchPosArray addObject:matchPosDes];
}

- (BOOL)GetPhoneNum:(NSNumber*)localID phone:(NSMutableArray*)phoneArray matchPos:(NSMutableArray*)matchPosArray {
    [phoneArray removeAllObjects];
    [matchPosArray removeAllObjects];
    
    u2char phoneBuf[256];
    
    Array* aMatchPosInPhoneNum = NULL;
	if  (matchPosArray) {
		aMatchPosInPhoneNum = new Array;
		ArrayInit(aMatchPosInPhoneNum);
    }
    
    NSMutableString *phoneDes = [[NSMutableString alloc] init];
    NSMutableArray *matchPos = [[NSMutableArray alloc] init];
    BOOL result = Tree_GetPhoneNum(&iSearchTree,[localID longValue],(u2char*)phoneBuf,aMatchPosInPhoneNum);
    int length = u2slen(phoneBuf);
    [phoneDes appendString:[NSString stringWithCharacters:(unichar*)phoneBuf length:length]];
	if (aMatchPosInPhoneNum) {
        [self ArrayToNSArray:aMatchPosInPhoneNum NSArray:matchPos];
        aMatchPosInPhoneNum->Reset(aMatchPosInPhoneNum);
		delete aMatchPosInPhoneNum;
    }
    
    [self ChangeToOranagePhones:phoneDes matchPos:matchPos phoneArray:phoneArray matchPosArray:matchPosArray];
    return result;
}

- (void)Reset {
    if (matchFunction) {
        matchFunction=nil;
    }
    
    FreeSearchTree(&iSearchTree);
    SearchTreeInit(&iSearchTree);
}
- (void)dealloc {
    //释放多音字库
    ReleaseMultiPYinWords();
    //释放搜索库
    FreeSearchTree(&iSearchTree);
	
    if (separateWord) {
        separateWord =nil;
    }
    if (matchFunction) {
        matchFunction=nil;
    }

}
@end
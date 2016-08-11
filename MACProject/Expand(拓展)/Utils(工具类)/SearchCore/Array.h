#ifndef Array_H
#define Array_H

/*
 ============================================================================
 Author: SearchCore

	注意 Array使用，定义后需进行初始化ArrayInit，使用后需释放资源Reset
	例如:
	Array text;
	ArrayInit( &text );
	text.Reset( &text );
 ============================================================================
*/


#include <stdio.h>
#include <stdlib.h>

//最大空间为   MALLOC_SIZE*INDEX_NUM_MAX = 12800

#define MALLOC_NUM  8   //2进制  个数为1<<MALLOC_NUM
#define MALLOC_SIZE 256 // = 1<<MALLOC_NUM
#define INDEX_NUM_MAX  50



#define MallocIndexByte (INDEX_NUM_MAX*sizeof(long))
#define MallocByte (MALLOC_SIZE*sizeof(long))

typedef struct ArrayData
{
	long* pData;
	struct ArrayData* next;
}ArrayData;

typedef struct Array
{	
	long size;
	long mallocsize;       //数据域个数

	long** pIndexData;	  //索引空间首地址
	long pIndexNum;        //索引空间个数

	long* pDataEnd;

	void (*Append)(struct Array* A,long value);
	void (*Insert)(struct Array* A,long value,long pos);
	void (*Remove)(struct Array* A,long index);
	void (*Reset)(struct Array* A);
	long  (*GetValue)(struct Array* A,long index);

}Array;

void ArrayInit(struct Array* A);
void ArrayAppend(Array* A,long value);
void ArrayInsert(Array* A,long value,long pos);
void ArrayRemove(Array* A,long index);
void ArrayReset(Array* A);
long ArrayReSize(Array* A);
long ArrayGetValue(Array* A,long index);


typedef struct ArrayC
{	
	long  size;			
	long  pDataSize;       //数据域个数
	long *pData;         //空间首地址
	
	long* pDataEnd;

	void (*Append)(struct ArrayC* A,long value);
	void (*Reset)(struct ArrayC* A);
	void (*SetSize)(struct ArrayC* A,long size);
	long (*GetValue)(struct ArrayC* A,long index);

}ArrayC;


void ArrayCInit(struct ArrayC* A);
void ArrayCAppend(ArrayC* A,long value);
void ArrayCReset(ArrayC* A);
long  ArrayCGetValue(ArrayC* A,long index);
void ArrayCSetSize(struct ArrayC* A,long size);

#endif

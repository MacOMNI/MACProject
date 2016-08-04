#include "Array.h"

long sizeof_long = sizeof(long);

void ArrayInit(struct Array* A)
{
	A->size = 0;
	A->mallocsize = 0;

	A->pIndexData = 0;
	A->pIndexNum = 0;

	A->pDataEnd = 0;

	A->Append = &ArrayAppend;
	A->Insert =	&ArrayInsert;
	A->Remove = &ArrayRemove;
	A->Reset = &ArrayReset;
	A->GetValue = &ArrayGetValue;
	return;
}

void ArrayAppend(Array* A,long value)
{
	if( A->size < A->mallocsize || ArrayReSize( A ) > 0 )
	{
		*A->pDataEnd = value;
		A->size ++;

		if( A->size < A->mallocsize )
			A->pDataEnd ++;
	}

	return;
}
void ArrayInsert(Array* A,long value,long pos)
{
	long size = A->size;
	long i = 0;
	long* ptr = 0;
	long* ptr0 = 0;
	long** ptr_index = 0;

	if(pos >= 0 && pos <= size)
	{
		if( size < A->mallocsize || ArrayReSize(A) )	
		{
			ptr = A->pDataEnd;
			i = size;
			ptr_index = A->pIndexData + (A->size >> MALLOC_NUM);
			while(i > pos)
			{
				if( ptr == *ptr_index )
				{
					ptr_index --;
					ptr0 = *ptr_index;
					ptr0 = ptr0 + MALLOC_SIZE - 1;
				}
				else
				{
					ptr0 = ptr - 1;
				}

				*ptr = *ptr0;
				ptr = ptr0;
				i --;
			}

			*ptr = value;
			size ++;
			A->size = size;

			if( size < A->mallocsize )
				A->pDataEnd ++;
		}
	}

	return;
}
void ArrayRemove(Array* A,long index)
{
	long size = A->size;
	long i; 
	long* ptr0 = 0;
	long* ptr = 0;
	long* ptr_temp = 0;
	long** ptr_index = 0;
	long pIndex = 0;
	
	if(index >= 0 && index < size)
	{	
		i = index;

		pIndex = index >> MALLOC_NUM;
		ptr_index = A->pIndexData + pIndex;
		index = index & (MALLOC_SIZE - 1);
		ptr_temp = *ptr_index;
		ptr0 = ptr = ptr_temp + index;
		size --;
	
		while(i < size)
		{
			index ++;
			if( index >= MALLOC_SIZE )
			{
				ptr_index ++;
				ptr = *ptr_index;
				index = 0;
			}
			else
			{
				ptr = ptr0 + 1;
			}
			*ptr0 = *ptr;
			ptr0 = ptr;
			i ++;
		} 

		A->size = size;
		A->pDataEnd = ptr;
	}

	return;
}
void ArrayReset(Array* A)
{
	long i = 0;
	
	for(i = 0;i < A->pIndexNum;i ++)
		free(*(A->pIndexData+i));	

	if( A->pIndexData )
		free(A->pIndexData);
	
	
	ArrayInit(A);
}

long ArrayReSize(Array* A)
{
	long	newsize;
	long* desData;
	long mallocsize = MallocByte;
	long mallocindexsize = MallocIndexByte;

	//内存不够
	if(A->pIndexNum + 1 >= INDEX_NUM_MAX )
		return 0;

	if( !A->pIndexData )
		A->pIndexData = (long**)malloc(mallocindexsize);
	
	newsize = A->mallocsize + MALLOC_SIZE;
	desData = (long*)malloc(mallocsize);

	*(A->pIndexData+A->pIndexNum) = desData;
	A->pIndexNum ++;

	A->pDataEnd = desData;
	A->mallocsize = newsize;

	return 1;
}

long ArrayGetValue(Array* A,long index)
{
	long* ptr = 0;
	long* ptr_index = 0;
	long pIndex = 0;

	if(index >= 0 && index < A->size)
	{
		pIndex = index >> MALLOC_NUM;
		ptr_index = *(A->pIndexData + pIndex);
		index = index & (MALLOC_SIZE - 1);
		ptr = ptr_index + index;

		return *ptr;
	}
	return -1;
}

void ArrayCInit(struct ArrayC* A)
{
	A->pData = 0;
	A->size = 0;
	A->pDataSize = 0;
	A->pDataEnd = 0;
	
	A->Append = &ArrayCAppend;
	A->Reset = &ArrayCReset;
	A->GetValue = &ArrayCGetValue;
	A->SetSize = &ArrayCSetSize;
	return;
}
void ArrayCAppend(ArrayC* A,long value)
{
	if( A->size < A->pDataSize )
		{
		*A->pDataEnd = value;
		A->size ++;

		if( A->size < A->pDataSize )
			A->pDataEnd ++;
		}
	return;
}
void ArrayCReset(ArrayC* A)
{
	if( A->pData )
	{
		free(A->pData);
	}

	ArrayCInit(A);
}
long  ArrayCGetValue(ArrayC* A,long index)
{
	if( index >= 0 && index < A->size )
		return *(A->pData + index);
	
	return -1;
}

void ArrayCSetSize(struct ArrayC* A,long size)
{
    if( A->pDataSize > 0 )
    	return;
    
    A->pDataSize = size;
    A->pData = (long*)malloc(size*sizeof_long);
	A->pDataEnd = A->pData;
}

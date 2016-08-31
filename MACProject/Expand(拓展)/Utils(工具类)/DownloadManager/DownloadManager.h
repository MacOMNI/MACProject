//
//  DownloadManager.h
//

#import <Foundation/Foundation.h>
#import "DownloadOperation.h"

#define DownloadDirectory [DownloadManager manager].downloadDirectory


@interface DownloadManager : NSObject

@property (strong, nonatomic, readonly) NSArray<DownloadOperation *> *operations;

@property (strong, nonatomic, readonly) NSString *downloadDirectory;

+ (instancetype)manager;

- (DownloadOperation *)operationWithURL:(NSURL *)url;


@end

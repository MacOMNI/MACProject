//
//  DownloadManager.m
//


#import "DownloadManager.h"

@interface DownloadManager ()
<NSURLSessionDataDelegate>

{
    NSMutableArray<DownloadOperation *> *_operations;
}

@property (strong, nonatomic) NSURLSession *session;

@property (strong, nonatomic) NSOperationQueue *queue;

@end



@implementation DownloadManager

+ (instancetype)manager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        config.allowsCellularAccess = NO;
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        _operations = [NSMutableArray array];
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
        
        _downloadDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        BOOL isDirectory;
        [[NSFileManager defaultManager] fileExistsAtPath:_downloadDirectory isDirectory:&isDirectory];
        if (!isDirectory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_downloadDirectory withIntermediateDirectories:YES attributes:NULL error:NULL];
        }
        
        
    }
    return self;
}

- (DownloadOperation *)operationWithURL:(NSURL *)url {
    __block DownloadOperation *operation;
    [_operations enumerateObjectsUsingBlock:^(DownloadOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.url isEqual:url]) {
            operation = obj;
            *stop = YES;
        }
    }];
    if (!operation) {
        operation = [[DownloadOperation alloc] initWithURL:url session:_session queue:_queue];;
        [_operations addObject:operation];
        [operation addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return operation;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (![object isKindOfClass:[DownloadOperation class]]) {
        return;
    }
}


#pragma mark - NSURLSessionTaskDelegate

/**
 *  收到 response
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    // 如果是视频文件
    if ([response.MIMEType rangeOfString:@"video"].length) {
        // 继续
        completionHandler(NSURLSessionResponseAllow);
    }
    else {
        // 取消
        completionHandler(NSURLSessionResponseCancel);
        NSLog(@"response.MIMEType %@", response.MIMEType);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    [task.operation completeWithError:error];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [dataTask.operation receiveData:data];
}

#pragma mark - Get / Set

- (NSArray<DownloadOperation *> *)operations {
    return _operations;
}

@end

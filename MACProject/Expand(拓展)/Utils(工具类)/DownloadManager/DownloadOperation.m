//
//  DownloadOperation.m
//

#import "DownloadOperation.h"
#import "DownloadManager.h"

@protocol __DownloadOperationDelegate <NSObject>

- (void)start;
- (void)stop;

@end

@interface __DownloadOperation : NSOperation
{
    BOOL _finished;
    BOOL _executing;
    BOOL _cancelled;
}

@property (assign, nonatomic) id<__DownloadOperationDelegate> delegate;

- (void)finish;

@end





@interface DownloadOperation ()
<__DownloadOperationDelegate>

@property (strong, nonatomic, nullable) NSURL *url;




@property (strong, nonatomic, readonly, nonnull) __DownloadOperation *operation;
@property (weak, nonatomic, nullable) NSOperationQueue *weakQueue;

@property (weak, nonatomic) NSURLSession *session;
@property (weak, nonatomic) NSURLSessionDataTask *dataTask;


@property (strong, nonatomic) NSFileHandle *fileHandle;

@property (assign, nonatomic) unsigned long long downloadOffset;

@property (assign, nonatomic) CFAbsoluteTime time;
@property (assign, nonatomic) unsigned long long bytesReceived;

@end

@implementation DownloadOperation

- (instancetype)initWithURL:(NSURL *)url session:(NSURLSession *)session queue:(NSOperationQueue *)queue {
    if (self = [super init]) {
        _url = [url copy];
        _session = session;
        _status = DownloadOperationStatusNone;
        _operation = [[__DownloadOperation alloc] init];
        _operation.delegate = self;
        self.weakQueue = queue;
    }
    return self;
}

- (void)resume {
    if (self.status == DownloadOperationStatusNone ||
        self.status == DownloadOperationStatusPause) {
        [self.weakQueue addOperation:self.operation];
        self.status = DownloadOperationStatusWaiting;
    }
}
- (void)pause {
    [self.dataTask suspend];
    [self.operation finish];
    _operation = [[__DownloadOperation alloc] init];
    _operation.delegate = self;
    self.status = DownloadOperationStatusPause;
}

- (void)stop {
    [self.dataTask cancel];
}

#pragma mark __DownloadOperationDelegate
- (void)start {
    
    if (_dataTask) {
        self.status = DownloadOperationStatusRuning;
        [_dataTask resume];
    }
    else {
        if (self.url) {
            self.status = DownloadOperationStatusRuning;
            [self.dataTask resume];
        }
        else {
            self.status = DownloadOperationStatusGetURLing;
        }
    }
}

#pragma mark NSURLSessionDelegate
- (void)receiveData:(NSData *)data {
    _bytesReceived += data.length;
    
    CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
    if (currentTime - _time > 1 || _speed == 0) {
        _speed = _bytesReceived / (currentTime - _time);
        _time = currentTime;
        _bytesReceived = 0;
    }
    
    [_fileHandle writeData:data];
    [_fileHandle seekToEndOfFile];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        !_progressChanged ?: _progressChanged(self);
    });
}

- (void)completeWithError:(NSError *)error {
    [_fileHandle closeFile];
    if (error) {
        [[NSFileManager defaultManager] removeItemAtPath:_filePath error:NULL];
        self.status = DownloadOperationStatusFailure;
    }
    else {
        NSString *toPath = [_filePath stringByAppendingPathExtension:_dataTask.response.suggestedFilename.pathExtension];
        NSURL *toURL = [NSURL fileURLWithPath:toPath];
        if (![[NSFileManager defaultManager] moveItemAtURL:[NSURL fileURLWithPath:_filePath] toURL:toURL error:NULL]) {
            [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:_filePath] error:NULL];
        };
        _filePath = toPath;
        self.status = DownloadOperationStatusSuccess;
    }
}

#pragma mark get / set

- (void)setStatus:(DownloadOperationStatus)status {
    _status = status;
    switch (status) {
        case DownloadOperationStatusFailure:
        case DownloadOperationStatusSuccess:
            [self.operation finish];
            break;
            
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        !_statusChanged ?: _statusChanged(self);
    });
}

- (NSURLSessionDataTask *)dataTask {
    if (!_dataTask) {
        _filePath = [NSString stringWithFormat:@"%@/%@", DownloadDirectory, @"download"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:_filePath]) {
            [[NSFileManager defaultManager] createFileAtPath:_filePath contents:NULL attributes:NULL];
        }
        
        _fileHandle = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
        [_fileHandle seekToEndOfFile];
        _downloadOffset = _fileHandle.offsetInFile;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
        NSString *range = [NSString stringWithFormat:@"bytes=%llu-", _downloadOffset];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        _dataTask = [_session dataTaskWithRequest:request];
        _dataTask.operation = self;
    }
    return _dataTask;
}

- (unsigned long long)countOfBytesReceived {
    return _downloadOffset + [_dataTask countOfBytesReceived];
}

- (unsigned long long)countOfBytesExpectedToReceive {
    return _downloadOffset + [_dataTask countOfBytesExpectedToReceive];
}

- (void)setProgressChanged:(void (^)(DownloadOperation * _Nonnull))progressChanged {
    _progressChanged = [progressChanged copy];
    !_progressChanged ?: _progressChanged(self);
}
- (void)setStatusChanged:(void (^)(DownloadOperation * _Nonnull))statusChanged {
    _statusChanged = [statusChanged copy];
    !_statusChanged ?: _statusChanged(self);
}

@end



#pragma mark - Operation

@implementation __DownloadOperation

- (void)finish {
    [self setExecuting:NO];
    [self setFinished:YES];
    NSLog(@"finish");
}

- (void)start {
    if (self.isCancelled) {
        [self.delegate stop];
        return;
    }
    [self.delegate start];
    [self setExecuting:YES];
}

- (void)cancel {
    if (self.isExecuting) {
        [self.delegate stop];
        self.executing = NO;
    }
    [self setFinished:YES];
}

#pragma mark Get/Set

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isFinished {
    return _finished;
}
- (BOOL)finished {
    return _finished;
}
- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}


- (BOOL)isExecuting {
    return _executing;
}
- (BOOL)executing {
    return _executing;
}
- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}


- (BOOL)isCancelled {
    return _cancelled;
}
- (BOOL)cancelled {
    return _cancelled;
}
- (void)setCancelled:(BOOL)cancelled {
    [self willChangeValueForKey:@"isCancelled"];
    _cancelled = cancelled;
    [self didChangeValueForKey:@"isCancelled"];
}


@end


#pragma mark - NSURLSessionTask+Download

@implementation NSURLSessionTask (__Download)

- (void)setOperation:(DownloadOperation *)operation {
    objc_setAssociatedObject(self, @selector(operation), operation, OBJC_ASSOCIATION_ASSIGN);
}
- (DownloadOperation *)operation {
    DownloadOperation *operation = objc_getAssociatedObject(self, @selector(operation));
    if ([operation isKindOfClass:[DownloadOperation class]]) {
        return operation;
    }
    else {
        return NULL;
    }
}


@end
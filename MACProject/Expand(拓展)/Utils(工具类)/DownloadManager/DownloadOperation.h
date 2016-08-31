//
//  DownloadOperation.h
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, DownloadOperationStatus) {
    DownloadOperationStatusNone,
    DownloadOperationStatusWaiting,
    DownloadOperationStatusGetURLing,
    DownloadOperationStatusRuning,
    DownloadOperationStatusPause,
    DownloadOperationStatusSuccess,
    DownloadOperationStatusFailure,
};


@interface DownloadOperation : NSObject

@property (strong, nonatomic, readonly, nullable) NSURL *url;


@property (assign, nonatomic, readonly) DownloadOperationStatus status;

@property (assign, nonatomic, readonly) unsigned long long countOfBytesReceived;

@property (assign, nonatomic, readonly) unsigned long long countOfBytesExpectedToReceive;

@property (assign, nonatomic, readonly) unsigned long long speed;

@property (strong, nonatomic, readonly, nonnull) NSString *filePath;

@property (copy, nonatomic, nullable) void (^progressChanged)(DownloadOperation * _Nonnull peration);
@property (copy, nonatomic, nullable) void (^statusChanged)(DownloadOperation * _Nonnull peration);


- (nonnull instancetype)initWithURL:(nonnull NSURL *)url session:(nonnull NSURLSession *)session queue:(nonnull NSOperationQueue *)queue;


- (void)resume;

- (void)pause;

- (void)stop;

- (void)receiveData:(nonnull NSData *)data;

- (void)completeWithError:(nullable NSError *)error;

@end



@interface NSURLSessionTask (Download)

@property (weak, nonatomic, nullable) DownloadOperation *operation;

@end




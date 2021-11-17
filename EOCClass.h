//
//  EOCClass.h
//  NSCache
//
//  Created by mac on 2021/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EOCNetworkFetcherCompletionHandler)(NSData *data);

@interface EOCClass : NSObject

- (id)initWithURL:(NSURL *)url;
- (void)sartWithCompletionHandler:(EOCNetworkFetcherCompletionHandler)handler;

- (void)test;
@end

@interface EOCClass (Test)
//- (void)test;
@end

NS_ASSUME_NONNULL_END

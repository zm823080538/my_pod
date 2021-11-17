//
//  EOCClass.m
//  NSCache
//
//  Created by mac on 2021/9/15.
//

#import "EOCClass.h"

@implementation EOCClass {
    NSCache *_cache;
}


//加载时调用
+ (void)load {
    NSLog(@"EOCClass load");
}

//运行期系统来调用的。不能通过代码直接调用，是惰性调用的
+ (void)initialize {
    NSLog(@"initialize");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [NSCache new];
        //Cache a maximun of 100 URLS
        _cache.countLimit = 100;
        //set a cost limit of 5MB.
        _cache.totalCostLimit = 5 * 1024 * 1024;

    }
    return self;
}

- (void)useData:(NSData *)data {
    
}

- (void)downloadDataForURL:(NSURL *)url {
//    NSData *cachedData = [_cache objectForKey:url];
//    if (cachedData) {
//        [self useData:cachedData];
//    } else {
//        //download Data,下载成功后再 存到cache里面
//        NSData *data = nil;
//        //加了cost，计算data的字节
//        [_cache setObject:data forKey:url cost:data.length];
//        [self useData:data];
//    }
    
    //用NSPurgeableData来实现更好
    NSPurgeableData *cachedData = [_cache objectForKey:url];
    if (cachedData) {
        // stop the data being purged
        //告诉它现在还不应该丢弃自己所占据的内存。
        [cachedData beginContentAccess];
        [self useData:cachedData];
    } else {
        NSPurgeableData *purgeableData = [NSPurgeableData dataWithData:nil];
        //加了cost，计算data的字节
        [_cache setObject:purgeableData forKey:url cost:purgeableData.length];
        [self useData:purgeableData];
        //告诉它在必要时可以丢弃自己所占据的内存了
        [purgeableData endContentAccess];
        
        //如果将NSPurgeableData对象加入NSCache，那么当该对象为系统所丢弃时，也会从缓存中移除，使用evictsObjectsWithDiscardedContent，可以开启或关闭此功能
        //        _cache.evictsObjectsWithDiscardedContent = YES;
    }
}

- (void)test {
    NSLog(@"class test");
}
@end

@implementation EOCClass (Test)

+ (void)load {
    NSLog(@"EOC class test");
}

- (void)test {
    NSLog(@"class category test 22");
}

@end

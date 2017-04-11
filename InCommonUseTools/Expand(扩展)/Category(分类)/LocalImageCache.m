//
//  LocalImageCache.m
//  91Market
//
//  Created by lory qing on 3/22/12.
//  Copyright (c) 2012 wanglong. All rights reserved.
//

#import "LocalImageCache.h"

@interface LocalImageCache()

- (void)clearMemory;

@end

@implementation LocalImageCache

@synthesize imageCache = _imageCache;

#pragma mark - init

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        _lock = [[NSLock alloc] init];
        #ifdef __IPHONE_4_0
        UIDevice *device = [UIDevice currentDevice];
        if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported) {
            // When in background, clean memory in order to have less chance to be killed
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(clearMemory)
                                                         name:UIApplicationDidEnterBackgroundNotification
                                                       object:nil];
        }
        #endif
        
        _imageCache = [[NSMutableDictionary alloc] initWithCapacity:5];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public func

+ (LocalImageCache *)sharedInstance {
    static LocalImageCache *kLocalImageCache = nil;
    if (nil == kLocalImageCache) {
        kLocalImageCache = [[LocalImageCache alloc] init];
    }
    return kLocalImageCache;
}

- (UIImage *)imageCacheWithName:(NSString *)imageName {
     NSString *imgFilePath = [NSString stringWithFormat:@"%@/",[[NSBundle mainBundle] bundlePath]];
    return [self imageForPath:imgFilePath imageName:imageName];
}

- (UIImage *)imageForPath:(NSString *)imagePath imageName:(NSString *)imageName {
    [_lock lock];
    UIImage *img = [self.imageCache objectForKey:imageName];
    if (nil == img) {
        img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",imagePath,imageName]];
        if (nil != img) {
            [self.imageCache setObject:img forKey:imageName];
        }
    }
    [_lock unlock];
    return img;
}

- (void)clearCache {
    [_lock lock];
    [self.imageCache removeAllObjects];
    [_lock unlock];
}

#pragma mark - Private func

- (void)clearMemory {
    [self clearCache];
}

@end

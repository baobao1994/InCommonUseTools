//
//  LocalImageCache.h
//  91Market
//
//  Created by lory qing on 3/22/12.
//  Copyright (c) 2012 wanglong. All rights reserved.
//

@interface LocalImageCache : NSObject {
    NSMutableDictionary *_imageCache;
    NSLock  *_lock;
}

@property (nonatomic, retain) NSMutableDictionary *imageCache;

+ (LocalImageCache *)sharedInstance;
- (UIImage *)imageCacheWithName:(NSString *)imageName;
- (UIImage *)imageForPath:(NSString *)imagePath imageName:(NSString *)imageName;
- (void)clearCache;

@end
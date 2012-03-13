//
//  AFImagePrefetcher.m
//  tinyreview
//
//  Created by Dick Brouwer on 12/3/11.
//  Copyright (c) 2011 Beeem Inc. All rights reserved.
//

#import "AFImagePrefetcher.h"
#import "AFImageCache.h"
#import "AFImageRequestOperation.h"

static AFImagePrefetcher *sharedAFImagePrefetcher = nil;

@implementation AFImagePrefetcher

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue {
    static NSOperationQueue *_imageRequestOperationQueue = nil;
    
    if (!_imageRequestOperationQueue) {
        _imageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_imageRequestOperationQueue setMaxConcurrentOperationCount:2];
    }
    
    return _imageRequestOperationQueue;
}

+ (id)sharedAFImagePrefetcher {
    if (sharedAFImagePrefetcher == nil) {
        sharedAFImagePrefetcher = [[AFImagePrefetcher alloc] init];
    }
    return sharedAFImagePrefetcher;
}

- (void)prefetchURLs:(NSArray *)urls {
    for (NSURL *url in urls) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
        [request setHTTPShouldHandleCookies:NO];
        [request setHTTPShouldUsePipelining:YES];
        
        UIImage *cachedImage = [[AFImageCache sharedImageCache] cachedImageForURL:[request URL] cacheName:nil];
        if (!cachedImage) {
            AFImageRequestOperation *af_imageRequestOperation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil cacheName:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {            
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            }];
            
            [[[self class] af_sharedImageRequestOperationQueue] addOperation:af_imageRequestOperation];
        }
    }
}

@end

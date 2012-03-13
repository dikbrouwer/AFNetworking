//
//  AFImagePrefetcher.h
//  tinyreview
//
//  Created by Dick Brouwer on 12/3/11.
//  Copyright (c) 2011 Beeem Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFImagePrefetcher : NSObject

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue;
+ (id)sharedAFImagePrefetcher;
- (void)prefetchURLs:(NSArray *)urls;

@end

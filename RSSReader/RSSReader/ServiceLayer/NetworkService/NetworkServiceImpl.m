//
//  NetworkServiceImpl.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "NetworkServiceImpl.h"

@implementation NetworkServiceImpl

- (void)loadDataWithURL:(NSURL *)dataURL
             completion:(LoadDataCompletionBlock)completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session dataTaskWithURL:dataURL
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (completion) {
                                                        completion(data, error);
                                                    }
                                                }];
    [downloadTask resume];
}

@end


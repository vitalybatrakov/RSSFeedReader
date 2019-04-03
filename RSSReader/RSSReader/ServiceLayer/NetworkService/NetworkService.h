//
//  NetworkService.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

typedef void (^LoadDataCompletionBlock)(NSData* _Nullable data, NSError * _Nullable error);

@protocol NetworkService <NSObject>

- (void)loadDataWithURL:(NSURL * _Nonnull)dataURL
             completion:(LoadDataCompletionBlock)completion;

@end

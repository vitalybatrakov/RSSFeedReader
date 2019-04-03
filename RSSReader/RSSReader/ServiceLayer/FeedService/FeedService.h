//
//  FeedService.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

@class Feed;
@class FeedSource;

typedef void (^FeedCompletionBlock)(NSArray<Feed *> * _Nullable feeds, NSError * _Nullable error);
typedef void (^SourceCompletionBlock)(NSString * _Nullable title, NSError * _Nullable error);

@protocol FeedService <NSObject>

- (void)fetchFeedsWithSources:(NSArray<FeedSource *> * _Nonnull)sources
                   completion:(FeedCompletionBlock)completionBlock;
- (void)getSourceTitleWithURL:(NSURL * _Nonnull)url
                   completion:(SourceCompletionBlock)completionBlock;

@end

//
//  FeedService.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

@class Feed;
@class FeedSource;

typedef void (^FeedCompletionBlock)(NSArray<Feed *> *feeds, NSError *error);
typedef void (^SourceCompletionBlock)(NSString *title, NSError *error);

@protocol FeedService <NSObject>

- (void)fetchFeedsWithSources:(NSArray<FeedSource *> *)sources completion:(FeedCompletionBlock)completionBlock;
- (void)getSourceTitleWithURL:(NSURL *)url completion:(SourceCompletionBlock)completionBlock;

@end

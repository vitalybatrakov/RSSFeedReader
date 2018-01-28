//
//  SourceStorage.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

@class FeedSource;

@protocol SourceStorage <NSObject>

- (NSArray<FeedSource *> *)getSources;
- (void)addSource:(FeedSource *)source;
- (void)saveSources:(NSArray<FeedSource *> *)sources;

@end

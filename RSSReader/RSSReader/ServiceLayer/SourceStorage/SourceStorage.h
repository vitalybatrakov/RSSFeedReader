//
//  SourceStorage.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

@class FeedSource;

@protocol SourceStorage <NSObject>

- (NSArray<FeedSource *> * _Nonnull)getSources;
- (void)addSource:(FeedSource * _Nonnull)source;
- (void)saveSources:(NSArray<FeedSource *> * _Nonnull)sources;

@end

//
//  Feed.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FEMMapping;
@class FeedItem;

@interface Feed : NSObject

@property (nonatomic, copy, readonly) NSString * _Nonnull title;
@property (nonatomic, strong, readonly) NSArray<FeedItem *> * _Nonnull feedItems;

- (void)setupFeedImageAndDescription;

@end

@interface Feed (Mapping)

+ (FEMMapping * _Nonnull)defaultMapping;

@end

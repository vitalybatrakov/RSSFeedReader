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

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray<FeedItem *> *feedItems;

- (void)setupFeedImageAndDescription;

@end

@interface Feed (Mapping)

+ (FEMMapping *)defaultMapping;

@end

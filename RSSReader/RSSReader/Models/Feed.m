//
//  Feed.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "Feed.h"
#import "FeedItem.h"
#import "FastEasyMapping.h"
#import "NSString+HTML.h"

@implementation Feed

- (void)setupFeedImageAndDescription {
    for (FeedItem *item in _feedItems) {
        [item setupImageUrlFromDescription];
        [item convertFeedDescriptionToPlainText];
    }
}

@end

@implementation Feed (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];
    
    [mapping addAttributesFromArray:@[@"title"]];
    [mapping addToManyRelationshipMapping:[FeedItem defaultMapping] forProperty:@"feedItems" keyPath:@"item"];
    
    return mapping;
}

@end

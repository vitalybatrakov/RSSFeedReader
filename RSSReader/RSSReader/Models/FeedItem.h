//
//  FeedItem.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FEMMapping;

@interface FeedItem : NSObject

@property (nonatomic, copy, readonly) NSString * _Nonnull title;
@property (nonatomic, copy, readonly) NSString * _Nonnull link;
@property (nonatomic, copy, readwrite) NSString * _Nonnull feedDescription;
@property (nonatomic, copy, readwrite) NSString * _Nullable imageURL;

- (void)setupImageUrlFromDescription;
- (void)convertFeedDescriptionToPlainText;

@end

@interface FeedItem (Mapping)

+ (FEMMapping * _Nonnull)defaultMapping;

@end

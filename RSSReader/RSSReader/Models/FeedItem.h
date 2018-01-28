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

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *link;
@property (nonatomic, copy, readwrite) NSString *feedDescription;
@property (nonatomic, copy, readwrite) NSString *imageURL;

- (void)setupImageUrlFromDescription;
- (void)convertFeedDescriptionToPlainText;

@end

@interface FeedItem (Mapping)

+ (FEMMapping *)defaultMapping;

@end

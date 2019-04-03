//
//  FeedSource.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedSource : NSObject

@property (nonatomic, copy, readonly) NSString * _Nonnull title;
@property (nonatomic, copy, readonly) NSString * _Nonnull link;

- (instancetype)initWithTitle:(NSString * _Nonnull)title
                    urlString:(NSString * _Nonnull)link;

@end

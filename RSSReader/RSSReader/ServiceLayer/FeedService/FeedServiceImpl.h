//
//  FeedServiceImpl.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedService.h"

@protocol NetworkService;
@protocol XMLParser;

@interface FeedServiceImpl : NSObject <FeedService>

- (instancetype)initWithNetwork:(id<NetworkService>)networkService
                      rssParser:(id<XMLParser>)rssParser;

@end

//
//  SourceStorageImpl.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "SourceStorageImpl.h"
#import "FeedSource.h"

static NSString * const kFeedSourceId = @"FeedSources";
static NSString * const DefaultSourceTitleId = @"Habrahabr";
static NSString * const DefaultSourceLinkId =  @"https://habrahabr.ru/rss/interesting/";

@implementation SourceStorageImpl

- (NSArray<FeedSource *> *)getSources {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kFeedSourceId];
    NSArray<FeedSource *> *sources = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    if (sources == nil) {
        FeedSource *feedSource = [[FeedSource alloc] initWithTitle:DefaultSourceTitleId
                                                         urlString:DefaultSourceLinkId];
        sources = @[feedSource];
    }
    
    return sources;
}

- (void)addSource:(FeedSource *)source {
    NSMutableArray<FeedSource *> *sources = [[self getSources] mutableCopy];
    [sources addObject:source];
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:sources];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:kFeedSourceId];
    [defaults synchronize];
}

- (void)saveSources:(NSArray<FeedSource *> *)sources {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:sources];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:kFeedSourceId];
    [defaults synchronize];
}

@end

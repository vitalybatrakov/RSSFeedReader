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
static NSString * const HabrSourceTitleId = @"Habrahabr";
static NSString * const HabrSourceLinkId =  @"https://habrahabr.ru/rss/interesting/";
static NSString * const TechCrunchSourceTitleId = @"TechCrunch";
static NSString * const TechCrunchSourceLinkId =  @"https://techcrunch.com/feed/";

@implementation SourceStorageImpl

- (NSArray<FeedSource *> * _Nonnull)getSources {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:kFeedSourceId];
    NSArray<FeedSource *> *sources = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    if (sources == nil) {
        FeedSource *habrSource = [[FeedSource alloc] initWithTitle:HabrSourceTitleId
                                                         urlString:HabrSourceLinkId];
        FeedSource *techCrunchSource = [[FeedSource alloc] initWithTitle:TechCrunchSourceTitleId
                                                         urlString:TechCrunchSourceTitleId];
        sources = @[habrSource, techCrunchSource];
    }
    
    return sources;
}

- (void)addSource:(FeedSource * _Nonnull)source {
    NSMutableArray<FeedSource *> *sources = [[self getSources] mutableCopy];
    [sources addObject:source];
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:sources];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:kFeedSourceId];
    [defaults synchronize];
}

- (void)saveSources:(NSArray<FeedSource *> * _Nonnull)sources {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:sources];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:kFeedSourceId];
    [defaults synchronize];
}

@end


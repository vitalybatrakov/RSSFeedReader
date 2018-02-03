//
//  FeedServiceImpl.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedServiceImpl.h"
#import "FastEasyMapping.h"
#import "Feed.h"
#import "FeedSource.h"
#import "NetworkService.h"
#import "XMLParser.h"
#import "SourceStorage.h"

@interface FeedServiceImpl ()

@property (nonatomic, strong) id<NetworkService> networkService;
@property (nonatomic, strong) id<XMLParser> rssParser;

@end

@implementation FeedServiceImpl

- (instancetype)initWithNetwork:(id<NetworkService>)networkService
                      rssParser:(id<XMLParser>)rssParser {
    self = [super init];
    if (self) {
        _networkService = networkService;
        _rssParser = rssParser;
    }
    return self;
}

- (void)fetchFeedsWithSources:(NSArray<FeedSource *> *)sources
                          completion:(FeedCompletionBlock)completionBlock {
    dispatch_group_t serviceGroup = dispatch_group_create();
    NSMutableArray *feeds = [[NSMutableArray alloc] init];
    
    for (FeedSource *source in sources) {
        dispatch_group_enter(serviceGroup);
        
        NSURL *url = [NSURL URLWithString:source.link];
        
        [_networkService loadDataWithURL:url
                              completion:^(NSData *data, NSError *error) {
                                  if (data != nil && error == nil) {
                                      NSDictionary *xmlDoc = [_rssParser parseData:data];
                                      [self mapFeedTo:feeds fromDictionary:xmlDoc];
                                  }
                                  dispatch_group_leave(serviceGroup);
                              }];
    }
    dispatch_group_notify(serviceGroup, dispatch_get_main_queue(),^{
        completionBlock(feeds, nil);
    });
}

- (void)getSourceTitleWithURL:(NSURL *)url completion:(SourceCompletionBlock)completionBlock {
    [_networkService loadDataWithURL:url
                          completion:^(NSData *data, NSError *error) {
                              if (data != nil && error == nil) {
                                  NSDictionary *xmlDoc = [_rssParser parseData:data];
                                  NSString *title = [self getSourceTitleFromDictionary:xmlDoc];
                                  if (title != nil) {
                                      completionBlock(title, nil);
                                  } else {
                                      NSError * error = [self createErrorWithDescription:NSLocalizedString(@"kErrorMessage", nil)];
                                      completionBlock(nil, error);
                                  }
                              } else {
                                  completionBlock(nil, error);
                              }
                          }];
}

#pragma mark - Private methods

- (void)mapFeedTo:(NSMutableArray *)feeds fromDictionary:(NSDictionary *)dictionary {
    NSDictionary * feedDic = dictionary[@"channel"];
    if (feedDic != nil) {
        FEMMapping *mapping = [Feed defaultMapping];
        Feed *feed = [FEMDeserializer objectFromRepresentation:feedDic mapping:mapping];
        [feed setupFeedImageAndDescription];
        [feeds addObject:feed];
    }
}

- (NSString *)getSourceTitleFromDictionary:(NSDictionary *)dictionary {
    NSDictionary * channelDic = dictionary[@"channel"];
    NSString *title = channelDic[@"title"];
    return title;
}

- (NSError *)createErrorWithDescription:(NSString *)description {
    NSString *domain = @"com.vbat.RSSReader.ErrorDomain";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : description };
    NSError *error = [NSError errorWithDomain:domain
                                         code:-101
                                     userInfo:userInfo];
    return error;
}

@end

//
//  FeedSource.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "FeedSource.h"

@implementation FeedSource

- (instancetype)initWithTitle:(NSString *)title urlString:(NSString *)link {
    self = [super init];
    if (self) {
        _title = title;
        _link = link;
    }
    return self;
}

#pragma mark - encode methods

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _title = [decoder decodeObjectForKey:@"title"];
        _link = [decoder decodeObjectForKey:@"link"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_link forKey:@"link"];
}

@end

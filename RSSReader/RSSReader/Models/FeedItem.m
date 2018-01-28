//
//  FeedItem.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "FeedItem.h"
#import "FastEasyMapping.h"
#import "NSString+HTML.h"

@implementation FeedItem

- (void)setupImageUrlFromDescription {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:_feedDescription options:0 range:NSMakeRange(0, [_feedDescription length])];
    NSString *imageString = [_feedDescription substringWithRange:[result rangeAtIndex:2]];
    self.imageURL = imageString;
}

- (void)convertFeedDescriptionToPlainText {
     self.feedDescription = [_feedDescription stringByConvertingHTMLToPlainText];
}

@end

@implementation FeedItem (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[self class]];

    [mapping addAttributesFromArray:@[@"title", @"link"]];
    [mapping addAttributesFromDictionary:@{@"feedDescription" : @"description"}];

    return mapping;
}

@end

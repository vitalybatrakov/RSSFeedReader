//
//  XMLParserImpl.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "XMLParserImpl.h"
#import "XMLDictionary.h"

@implementation XMLParserImpl

- (NSDictionary * _Nonnull)parseData:(NSData * _Nonnull)data {
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLData:data];
    return xmlDoc;
}

@end

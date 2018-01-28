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

- (NSDictionary *)parseData:(NSData *)data {
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLData:data];
    return xmlDoc;
}

@end

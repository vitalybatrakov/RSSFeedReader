//
//  XMLParser.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

@protocol XMLParser <NSObject>

- (NSDictionary * _Nonnull)parseData:(NSData * _Nonnull)data;

@end

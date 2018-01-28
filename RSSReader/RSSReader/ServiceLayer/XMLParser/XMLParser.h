//
//  XMLParser.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

@protocol XMLParser <NSObject>

- (NSDictionary *)parseData:(NSData *)data;

@end

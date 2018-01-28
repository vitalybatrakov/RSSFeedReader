//
//  Section.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "Section.h"

@implementation Section

- (id)initWithItems:(NSArray *)items
              title:(NSString *)title {
    self = [super init];
    if (self) {
        _items = [items mutableCopy];
        _title = title;
    }
    return self;
}

@end


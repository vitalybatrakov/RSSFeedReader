//
//  Section.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

@property (nonatomic, copy, readonly) NSString * _Nonnull title;
@property (nonatomic, strong, readonly) NSMutableArray * _Nonnull items;

- (id)initWithItems:(NSArray * _Nonnull)items
              title:(NSString * _Nonnull)title;

@end

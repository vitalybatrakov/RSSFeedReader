//
//  Section.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSMutableArray *items;

- (id)initWithItems:(NSArray *)items
              title:(NSString *)title;

@end

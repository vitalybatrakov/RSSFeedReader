//
//  BaseTableViewDataSource.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);
typedef void (^SectionsChangeBlock)(id sections);

@interface BaseTableViewDataSource: NSObject <UITableViewDataSource>

- (id)initWithItems:(NSArray *)sections
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;

- (id)initWithItems:(NSArray *)sections
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
changeSectionsBlock:(SectionsChangeBlock)changeSectionsBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

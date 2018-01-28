//
//  BaseTableViewDelegate.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TableViewCellSelectionBlock)(NSIndexPath *indexPath);

@interface BaseTableViewDelegate : NSObject <UITableViewDelegate>

- (id)initWithSelectCellBlock:(TableViewCellSelectionBlock)selectCellBlock;

@end

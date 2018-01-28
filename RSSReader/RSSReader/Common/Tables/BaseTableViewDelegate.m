//
//  BaseTableViewDelegate.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "BaseTableViewDelegate.h"

@interface BaseTableViewDelegate ()

@property (nonatomic, copy) TableViewCellSelectionBlock selectCellBlock;

@end

@implementation BaseTableViewDelegate

- (id)initWithSelectCellBlock:(TableViewCellSelectionBlock)selectCellBlock {
    self = [super init];
    if (self) {
        _selectCellBlock = [selectCellBlock copy];
    }
    return self;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (_selectCellBlock) {
        _selectCellBlock(indexPath);
    }
}

@end

//
//  BaseTableViewDataSource.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "BaseTableViewDataSource.h"
#import "Section.h"

@interface BaseTableViewDataSource ()

@property (nonatomic, strong, readonly) NSArray *sections;
@property (nonatomic, copy, readonly) NSString *cellIdentifier;
@property (nonatomic, copy, readonly) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy, readonly) SectionsChangeBlock changeSectionsBlock;

@end

@implementation BaseTableViewDataSource

// init data source without reordering
- (id)initWithItems:(NSArray *)sections
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock {
    self = [super init];
    if (self) {
        _sections = sections;
        _cellIdentifier = [cellIdentifier copy];
        _configureCellBlock = [configureCellBlock copy];
        _changeSectionsBlock = nil;
    }
    return self;
}

// init data source with reordering/removing
- (id)initWithItems:(NSArray *)sections
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock
changeSectionsBlock:(SectionsChangeBlock)changeSectionsBlock {
    self = [self initWithItems:sections
                cellIdentifier:cellIdentifier
            configureCellBlock:configureCellBlock];
    if (self) {
        _changeSectionsBlock = [changeSectionsBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    Section *section = _sections[indexPath.section];
    return section.items[(NSUInteger) indexPath.row];
}

#pragma mark UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Section *sect = _sections[section];
    return sect.title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Section *sectionObject = _sections[section];
    return sectionObject.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    _configureCellBlock(cell, item);
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath != destinationIndexPath && _changeSectionsBlock != nil) {
        Section *section = _sections[sourceIndexPath.section];
        id item = [self itemAtIndexPath:sourceIndexPath];
        
        [section.items removeObjectAtIndex:sourceIndexPath.row];
        [section.items insertObject:item atIndex:destinationIndexPath.row];
        [tableView reloadData];
        
        _changeSectionsBlock(_sections);
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && _changeSectionsBlock != nil) {
        Section *section = _sections[indexPath.section];
        [section.items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        _changeSectionsBlock(_sections);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_changeSectionsBlock != nil) {
        return YES;
    } else {
        return NO;
    }
}

@end

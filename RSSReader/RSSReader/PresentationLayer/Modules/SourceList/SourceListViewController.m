//
//  SourceListViewController.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "SourceListViewController.h"
#import "Feed.h"
#import "BaseTableViewDataSource.h"
#import "BaseTableViewDelegate.h"
#import "Section.h"
#import "FeedSource.h"
#import "AddSourceViewController.h"
#import "SourceStorage.h"

static NSString * const SourceCellIdentifier = @"SourceTableViewCell";

@interface SourceViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BaseTableViewDataSource *dataSource;
@property (nonatomic, strong) BaseTableViewDelegate *delegate;

@end

@implementation SourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    NSArray * sources = [_sourceStorage getSources];
    NSArray * sections = [self sectionsFromSources:sources];
    [self setupDataSourceWithSections:sections];
    [self setupTableViewDelegate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}

- (void)setupTable {
    _tableView.allowsSelection = NO;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)updateTable {
    NSArray * sources = [_sourceStorage getSources];
    NSArray * sections = [self sectionsFromSources:sources];
    [self setupDataSourceWithSections:sections];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}

- (NSArray *)sectionsFromSources:(NSArray *)sources {
    NSMutableArray *sections = [NSMutableArray new];
    Section *section = [[Section alloc] initWithItems:sources title:@""];
    [sections addObject:section];
    return sections;
}

- (void)setupDataSourceWithSections:(NSArray *)sections {
    TableViewCellConfigureBlock configureCellBlock = ^(UITableViewCell *cell, FeedSource *source) {
        cell.textLabel.text = source.title;
        cell.detailTextLabel.text = source.link;
    };
    SectionsChangeBlock changeSectionsBlock = ^(NSArray<Section *> *sections) {
        Section *sourceSection = [sections firstObject];
        [_sourceStorage saveSources:sourceSection.items];
    };
    self.dataSource = [[BaseTableViewDataSource alloc] initWithItems:sections
                                                      cellIdentifier:SourceCellIdentifier
                                                  configureCellBlock:configureCellBlock
                                                 changeSectionsBlock:changeSectionsBlock];
    _tableView.dataSource = _dataSource;
}

- (void)setupTableViewDelegate {
    self.delegate = [[BaseTableViewDelegate alloc] initWithSelectCellBlock:nil];
    _tableView.delegate = _delegate;
}

- (IBAction)editButtonDidTap:(UIBarButtonItem *)sender {
    _tableView.editing = !_tableView.editing;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddSourceSegue"]) {
        AddSourceViewController *addSourceController = [segue destinationViewController];
        addSourceController.sourceStorage = _sourceStorage;
        addSourceController.feedService = _feedService;
        addSourceController.onAddSourceBlock = ^() {
            [self updateTable];
        };
    }
}

@end


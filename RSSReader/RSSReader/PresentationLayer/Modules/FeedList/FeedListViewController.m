//
//  FeedListViewController.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "FeedListViewController.h"
#import "BaseTableViewDataSource.h"
#import "BaseTableViewDelegate.h"
#import "SourceListViewController.h"
#import "SourceStorage.h"
#import "FeedService.h"
#import "Feed.h"
#import "FeedItem.h"
#import "Section.h"
#import "FeedDetailsViewController.h"
#import "FeedSource.h"
#import "FeedListTableViewCell.h"
#import "UIViewController+Alert.h"

static NSString * const FeedCellId = @"FeedListTableViewCell";

@interface FeedListViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) BaseTableViewDataSource *dataSource;
@property (nonatomic, strong) BaseTableViewDelegate *delegate;

@end

@implementation FeedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViewDelegate];
    [self setupFooter];
    [self setupRefreshControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self fetchFeeds];
}

- (void)fetchFeeds {
    NSArray *sources = [_sourceStorage getSources];
    [_feedService fetchFeedsWithSources:sources
                             completion:^(NSArray *array, NSError *error) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     if (array != nil && error == nil) {
                                         NSArray *sections = [self sectionsFromChannels:array];
                                         [self setupDataSourceWithSections:sections];
                                         [self stopRefreshing];
                                         [self updateTable];
                                     } else {
                                         [self showAlertWithErrorMessage:error.localizedDescription];
                                     }
                                 });
                             }];
}

- (NSArray *)sectionsFromChannels:(NSArray *)channels {
    NSMutableArray *sections = [NSMutableArray new];
    for (Feed *channel in channels) {
        Section *section = [[Section alloc] initWithItems: channel.feedItems title:channel.title];
        [sections addObject:section];
    }
    return sections;
}

- (void)setupDataSourceWithSections:(NSArray *)sections {
    TableViewCellConfigureBlock configureCell = ^(FeedListTableViewCell *cell, FeedItem *feed) {
        [cell.image sd_setImageWithURL:[NSURL URLWithString:feed.imageURL]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
        cell.titleLabel.text = feed.title;
        cell.detailLabel.text = feed.feedDescription;
    };
    _dataSource = [[BaseTableViewDataSource alloc] initWithItems:sections
                                                  cellIdentifier:FeedCellId
                                              configureCellBlock:configureCell];
    _tableView.dataSource = _dataSource;
}

- (void)setupTableViewDelegate {
    _delegate = [[BaseTableViewDelegate alloc] initWithSelectCellBlock:nil];
    _tableView.delegate = _delegate;
}

- (void)updateTable {
    [_tableView reloadData];
}

- (void)setupFooter {
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(refresh)
              forControlEvents:UIControlEventValueChanged];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:RRLocalize(@"kUpdateFeedsTitle")
                                                                                attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0]}];
    if (@available(iOS 10.0, *)) {
        _tableView.refreshControl = _refreshControl;
        [_tableView setContentOffset:CGPointMake(0, -_tableView.refreshControl.frame.size.height) animated:YES];
    } else {
        [_tableView insertSubview:_refreshControl atIndex:0];
    }
    [_refreshControl beginRefreshing];
}

- (void)refresh {
    [self fetchFeeds];
}

- (void)stopRefreshing {
    [_refreshControl endRefreshing];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SourceSegue"]) {
        SourceViewController *sources = [segue destinationViewController];
        sources.sourceStorage = _sourceStorage;
        sources.feedService = _feedService;
    } else if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        FeedDetailViewController *details = [segue destinationViewController];
        NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
        FeedItem * feedItem = [_dataSource itemAtIndexPath:indexPath];
        details.feedItem = feedItem;
    }
}

@end

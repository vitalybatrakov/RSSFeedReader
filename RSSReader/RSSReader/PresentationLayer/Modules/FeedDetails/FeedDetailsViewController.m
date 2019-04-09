//
//  FeedDetailsViewController.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "FeedDetailsViewController.h"
#import "FeedItem.h"
#import "WebPageViewController.h"

@interface FeedDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel * _Nonnull feedTitle;
@property (strong, nonatomic) IBOutlet UIImageView * _Nonnull feedImage;
@property (strong, nonatomic) IBOutlet UILabel * _Nonnull summary;

@end

@implementation FeedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextAndImageFormFeedItem];
}

- (void)setupTextAndImageFormFeedItem {
    _feedTitle.text = _feedItem.title;
    _summary.text = _feedItem.feedDescription;
    [_feedImage sd_setImageWithURL:[NSURL URLWithString:_feedItem.imageURL]
                  placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"WebPageSegue"]) {
        WebPageViewController *webPageViewController = [segue destinationViewController];
        webPageViewController.pageURLString = _feedItem.link;
    }
}

@end


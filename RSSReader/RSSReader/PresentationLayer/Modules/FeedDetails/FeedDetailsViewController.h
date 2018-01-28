//
//  FeedDetailsViewController.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedItem;

@interface FeedDetailViewController : UIViewController

@property (nonatomic, strong) FeedItem *feedItem;

@end

//
//  FeedListViewController.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FeedService;
@protocol  SourceStorage;

@interface FeedListViewController : UIViewController

@property (nonatomic, strong) id<FeedService> feedService;
@property (nonatomic, strong) id<SourceStorage> sourceStorage;

@end

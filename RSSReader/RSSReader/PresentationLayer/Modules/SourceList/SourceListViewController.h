//
//  SourceListViewController.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SourceStorage;
@protocol FeedService;

@interface SourceViewController : UIViewController

@property (nonatomic, strong) id<SourceStorage> sourceStorage;
@property (nonatomic, strong) id<FeedService> feedService;

@end

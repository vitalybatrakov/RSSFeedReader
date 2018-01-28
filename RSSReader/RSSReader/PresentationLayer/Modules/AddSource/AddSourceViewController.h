//
//  AddSourceViewController.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 08.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SourceStorage;
@protocol FeedService;

@interface AddSourceViewController : UIViewController

@property (nonatomic, strong) id<SourceStorage> sourceStorage;
@property (nonatomic, strong) id<FeedService> feedService;
@property (nonatomic, copy) void (^onAddSourceBlock)(void);

@end

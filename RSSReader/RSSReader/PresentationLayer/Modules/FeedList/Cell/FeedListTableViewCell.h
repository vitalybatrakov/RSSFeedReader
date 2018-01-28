//
//  FeedListTableViewCell.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 08.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeedListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

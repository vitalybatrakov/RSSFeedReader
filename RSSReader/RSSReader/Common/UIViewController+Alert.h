//
//  UIViewController+Alert.h
//  RSSReader
//
//  Created by Vitaly Batrakov on 15.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)showAlertWithErrorMessage:(NSString *)errorMessage;

@end

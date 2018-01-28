//
//  UIViewController+Alert.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 15.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)showAlertWithErrorMessage:(NSString *)errorMessage {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:RRLocalize(@"kLoadingErrorTitle")
                                 message:errorMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Button
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end

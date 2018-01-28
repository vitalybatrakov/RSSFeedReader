//
//  AddSourceViewController.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 08.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "AddSourceViewController.h"
#import "FeedSource.h"
#import "SourceStorage.h"
#import "FeedService.h"
#import "UIViewController+Alert.h"

@interface AddSourceViewController ()

@property (strong, nonatomic) IBOutlet UITextField *sourceTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;

@end

@implementation AddSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSourceTextField];
}

- (void)setupSourceTextField {
    _sourceTextField.placeholder = RRLocalize(@"kAddSourceTitle");
    _sourceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _sourceTextField.borderStyle = UITextBorderStyleRoundedRect;
}

- (IBAction)cancelButtonDidTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)addButtonDidTapped:(id)sender {
    BOOL isValidURL = [self validateURL];
    if (isValidURL) {
        [self showProgressIndicator];
        [self addSource];
    } else {
        [self showAlertWithErrorMessage:RRLocalize(@"kAddSourceErrorMessage")];
    }
}

- (void)addSource {
    NSURL *url = [NSURL URLWithString:_sourceTextField.text];
    [_feedService getSourceTitleWithURL:url completion:^(NSString *title, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self hideProgressIndicator];
                [self showAlertWithErrorMessage:error.localizedDescription];
            } else {
                FeedSource *newSource = [[FeedSource alloc] initWithTitle:title urlString:_sourceTextField.text];
                [_sourceStorage addSource:newSource];
                _onAddSourceBlock();
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        });
    }];
}

- (void)showProgressIndicator {
    [self.view setUserInteractionEnabled:false];
    [_progressIndicator startAnimating];
}

- (void)hideProgressIndicator {
    [self.view setUserInteractionEnabled:true];
    [_progressIndicator stopAnimating];
}

- (BOOL)validateURL {
    NSURL *url = [NSURL URLWithString:_sourceTextField.text];
    if (url != nil && url.scheme != nil && url.host != nil) {
        return YES;
    }
    return NO;
}

@end

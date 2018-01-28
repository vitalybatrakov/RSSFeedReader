//
//  WebPageViewController.m
//  RSSReader
//
//  Created by Vitaly Batrakov on 07.10.17.
//  Copyright © 2017 vbat. All rights reserved.
//

#import "WebPageViewController.h"
#import <WebKit/WebKit.h>

@implementation WebPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    NSURL *url = [NSURL URLWithString:_pageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

@end

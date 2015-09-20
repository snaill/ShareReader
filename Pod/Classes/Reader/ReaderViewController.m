//
//  Reader3ViewController.m
//  ShareReader
//
//  Created by Snaill on 15/9/16.
//  Copyright (c) 2015年 Snaill. All rights reserved.
//

#import "ReaderViewController.h"
#import <ShareOne/ShareOne.h>
#import <SVProgressHUD/SVProgressHUD.h>

#define API_BASE_URL        @"http://sharepai.net/"
#define URL_KEY_TYPE        @"type"
#define URL_KEY_ID          @"id"
#define URL_TYPE_POSTS      @"posts"

@interface ReaderViewController()<UIWebViewDelegate> {
    BOOL _webViewDidLoad;
}

@property (nonatomic, strong) NSString * postId;
@property (nonatomic, strong) NSURL * url;
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation ReaderViewController

- (void)readerWithPostID:(NSString *)ID {
    
    // Load the object model via RestKit
    self.url = [self urlForWithParams:@{URL_KEY_ID:ID, URL_KEY_TYPE: URL_TYPE_POSTS}];
    self.postId = ID;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webViewDidLoad = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onShare:)];

    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.webView stopLoading];
    self.webView.delegate = nil;
}

- (void)onShare:(id)sender {

    NSArray * activityItems = @[self.title, self.url];
    NSArray * activitys = [ShareOne activitysWithTypes:@[@(ShareOneTypeWeixin), @(ShareOneTypeWeixinTimeline), @(ShareOneTypeQQ), @(ShareOneTypeQZone)]];
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
    [self presentViewController:activityView animated:YES completion:nil];
}

- (NSURL *)urlForWithParams:(NSDictionary *)params {
    NSString * string = [NSString stringWithFormat:@"%@%@/%@.html", API_BASE_URL, [params valueForKey:URL_KEY_TYPE], [params valueForKey:URL_KEY_ID]];
    return [NSURL URLWithString:string];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (!_webViewDidLoad) {
        [SVProgressHUD show];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    _webViewDidLoad = YES;
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
    _webViewDidLoad = YES;
}

@end


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
#define KEY_USERAGENT       @"UserAgent"

@interface ReaderViewController()<UIWebViewDelegate> {
    BOOL _headerHidden;
}

@property (nonatomic, strong) NSURL * url;
@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) NSString * userAgent;
@end

@implementation ReaderViewController

- (void)readerWithPostID:(NSString *)ID {
    
    // Load the object model via RestKit
    self.url = [self urlForWithParams:@{URL_KEY_ID:ID, URL_KEY_TYPE: URL_TYPE_POSTS}];
}

- (void)readerWithURL:(NSURL *)url {
    
    // Load the object model via RestKit
    self.url = url;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    if (self.navigationController) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onShare:)];
        
        if ([self.navigationController.viewControllers count] > 1) {
            [self setUserAgent];
            _headerHidden = YES;
        }
    }
    
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
    
    if (_headerHidden) {
        NSDictionary *registeredDefaults = [[NSUserDefaults standardUserDefaults] volatileDomainForName:NSRegistrationDomain];
        if ([registeredDefaults objectForKey:KEY_USERAGENT] != nil) {
            NSMutableDictionary *mutableCopy = [NSMutableDictionary dictionaryWithDictionary:registeredDefaults];
            [mutableCopy removeObjectForKey:KEY_USERAGENT];
            if ([self.userAgent length] > 0) {
                [mutableCopy setObject:self.userAgent forKey:KEY_USERAGENT];
            }
            [[NSUserDefaults standardUserDefaults] setVolatileDomain:[mutableCopy copy] forName:NSRegistrationDomain];
        }
    }
}

- (void)onBack:(id)sender {
    [self.webView goBack];
    [self updateBackButton];
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

- (void)setUserAgent {
    
    self.userAgent = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_USERAGENT];
    
    NSString * userAgent = [[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString * appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *appUserAgent = [userAgent stringByAppendingFormat:@" sharepai.%@/%@", appName, version];
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{KEY_USERAGENT: appUserAgent}];
}

- (void)updateBackButton {
    if (!_headerHidden) {
        return;
    }
    
    if ([self.webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
        }
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self updateBackButton];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
}

#pragma mark - UINavigationBarDelegate

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    return NO;
}
@end


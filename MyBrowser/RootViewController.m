//
//  ViewController.m
//  MyBrowser
//
//  Created by May Yang on 1/20/15.
//  Copyright (c) 2015 May Yang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlTextField.delegate = self;
    [self.activityIndicator hidesWhenStopped];
    [self.activityIndicator stopAnimating];
}

//- (void)loadRequestFromString:(NSString *)urlString;
//{
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:urlRequest];
//}
#pragma mark - UIWEBVIEW DELEGATES
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator hidesWhenStopped];
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - UITEXTFIELD DELEGATES
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *urlTextField = self.urlTextField.text;
    NSURL *url = [NSURL URLWithString:urlTextField];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    return YES;
}


@end

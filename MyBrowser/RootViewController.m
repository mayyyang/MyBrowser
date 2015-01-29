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
@property (weak, nonatomic) IBOutlet UIButton *goBack;
@property (weak, nonatomic) IBOutlet UIButton *goForward;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlTextField.delegate = self;
    [self.activityIndicator hidesWhenStopped];
    [self.activityIndicator stopAnimating];
    
    self.urlTextField.text = @"http://";
    
    self.urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
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

    if ([self.webView canGoBack])
    {
        [self.goBack setEnabled:YES];
    }
    else
    {
        [self.goBack setEnabled:NO];
    }
    
    if ([self.webView canGoForward])
    {
        [self.goForward setEnabled:YES];
    }
    else
    {
        [self.goForward setEnabled:NO];
    }
    
    NSString *urlString = [[self.webView.request URL] absoluteString];
    self.urlTextField.text = urlString;
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange substringRange = [self.urlTextField.text rangeOfString:@"http://"];
    if (range.location >= substringRange.location && range.location < substringRange.location + substringRange.length)
    {
        return NO;
    }
    
    return YES;
}

#pragma mark - UIBUTTONS
- (IBAction)backButton:(UIButton *)sender
{
    [self.webView goBack];
}

- (IBAction)forwardButton:(UIButton *)sender
{
    [self.webView goForward];
}

- (IBAction)stopButton:(UIButton *)sender
{
    [self.webView stopLoading];
    [self.activityIndicator stopAnimating];
    [self.activityIndicator hidesWhenStopped];
}

- (IBAction)refreshButton:(UIButton *)sender
{
    [self.webView reload];
}

- (IBAction)plusButton:(UIButton *)sender
{
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Coming Soon!", @"Please fill in all fields") message:NSLocalizedString(@"", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil] show];
}

@end

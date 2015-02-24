//
//  ViewController.m
//  MyBrowser
//
//  Created by May Yang on 1/20/15.
//  Copyright (c) 2015 May Yang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *goBack;
@property (weak, nonatomic) IBOutlet UIButton *goForward;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property CGPoint pointNow;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.urlTextField.delegate = self;
    [self.activityIndicator hidesWhenStopped];
    [self.activityIndicator stopAnimating];
    
    self.urlTextField.text = @"http://";
    
    self.urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.webView.scrollView.delegate = self;
}


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
    
    self.titleLabel.text = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"No internet connection");
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
    self.urlTextField.alpha = 1.0;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.urlTextField.alpha = 1.0;
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

#pragma mark - UISCROLLVIEW DELEGATE
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<self.pointNow.y)
    {
        NSLog(@"up");
        self.urlTextField.alpha = 1.0;
    }
    else if (scrollView.contentOffset.y>self.pointNow.y)
    {
        NSLog(@"down");
        self.urlTextField.alpha = 0.5;
    }
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming soon"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end

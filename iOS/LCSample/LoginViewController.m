//
//  LoginViewController.m
//  LCSample
//
//  Created by Ian Cundiff on 1/19/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import "LoginViewController.h"
#import "KerberosAccountManager.h"

@implementation LoginViewController

@synthesize usernameField,passwordField, userNameTable, passwordTable, overlay, wheel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [usernameField setDelegate:self];
    [passwordField setDelegate:self];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == usernameField) {
        [textField resignFirstResponder];
        return NO;
    } else {
        overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
        overlay.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        
        [self.view addSubview:overlay];
        
        wheel = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        wheel.frame=CGRectMake(145, 160, 25, 25);
        wheel.tag  = 1;
        wheel.color = [UIColor whiteColor];
        
        [overlay addSubview:wheel];
        [wheel startAnimating];
        [[KerberosAccountManager defaultManager] setSourceURL:@"https://netreg.rose-hulman.edu/tools/networkUsage.pl"];
        [[KerberosAccountManager defaultManager] setUsername:[self.usernameField text]];
        [[KerberosAccountManager defaultManager] setPassword:[self.passwordField text]];
        
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[[KerberosAccountManager defaultManager] sourceURL]] 
                                                                     cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData 
                                                                 timeoutInterval:10.0];
        
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [conn start];
        [textField resignFirstResponder];
       
        return NO;
    }
    return NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"connection did receive authentication challenge");
    
    if([challenge previousFailureCount] == 0) {
        NSString * username = [[KerberosAccountManager defaultManager] username];
        NSString * password = [[KerberosAccountManager defaultManager] password];
//        NSLog(@"creating credentials with user:%@ pass:%@", username, password);
        NSURLCredential * cred = [[NSURLCredential alloc] initWithUser:username password:password persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
    } else {
        [wheel removeFromSuperview];
        [overlay removeFromSuperview];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Login Failed"
                                                          message:@"The username or password you entered was incorrect, please try again."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //if it gets here, that means that authentication was successful, therefore the user IS part of the RHIT kerberos database...
    //so we can probably just set some sort of boolean value
    //...more testing necessary
    [wheel removeFromSuperview];
    [overlay removeFromSuperview];
   [self dismissModalViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath row] == 0) return userNameTable;
    if([indexPath row] == 1) return passwordTable;
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}









@end

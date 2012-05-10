//
//  ContactViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactViewController : UIViewController <MFMailComposeViewControllerDelegate>

-(IBAction)callPressed:(id)sender;
-(IBAction)emailPressed:(id)sender;
-(IBAction)websitePressed:(id)sender;

@end

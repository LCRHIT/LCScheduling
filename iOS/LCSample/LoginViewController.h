//
//  LoginViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 1/19/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property(strong, nonatomic) IBOutlet UITextField *usernameField;
@property(strong, nonatomic) IBOutlet UITextField *passwordField;

@end

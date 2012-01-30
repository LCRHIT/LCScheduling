//
//  LoginViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 1/19/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>{
    IBOutlet UITableViewCell *userNameTable;
    IBOutlet UITableViewCell *passwordTable;
    
}

@property(strong, nonatomic) IBOutlet UITextField *usernameField;
@property(strong, nonatomic) IBOutlet UITextField *passwordField;
@property(strong, nonatomic) IBOutlet UITableViewCell *userNameTable;
@property(strong, nonatomic) IBOutlet UITableViewCell *passwordTable;


@end

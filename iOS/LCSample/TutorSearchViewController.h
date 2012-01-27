//
//  TutorSearchViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorSearchResultsViewController.h"
#import "DBInteract.h"

@interface TutorSearchViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *courseField;
@property (strong, nonatomic) IBOutlet UITextField *dateField;


-(IBAction)submitPressed:(id)sender;

@end

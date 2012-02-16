//
//  TutorSearchViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorProfileViewController.h"
#import "TutorSearchResultsViewController.h"
#import "DBInteract.h"

@interface TutorSearchViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *courseField;
@property (strong, nonatomic) IBOutlet UITextField *dateField;
@property (nonatomic, retain) IBOutlet UIDatePicker *customInput;
@property (nonatomic, retain) IBOutlet UIToolbar *accessoryView;


-(IBAction)submitPressed:(id)sender;
- (IBAction)dateChanged:(id)sender;
- (IBAction)doneEditing:(id)sender;

-(void)tutorsUpdated;

@end

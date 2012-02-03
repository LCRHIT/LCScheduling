//
//  TutorSearchViewController.m
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import "TutorSearchViewController.h"


@implementation TutorSearchViewController

@synthesize nameField, courseField, dateField, accessoryView,customInput;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Tutor Search", @"Tutor Search");
        
        
    }
    
    return self;
}


							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameField.delegate = self;
    self.courseField.delegate = self;
    self.dateField.inputView = self.customInput;
    self.dateField.inputAccessoryView = self.accessoryView;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"keyboard down");
    
    [textField resignFirstResponder];
    return NO;
    
}


-(IBAction)submitPressed:(id)sender 
{
    UINavigationController *otherNavController = (UINavigationController *)[[self.tabBarController viewControllers] objectAtIndex:1];
    
   // NSMutableArray *tutors = [[DBInteract sharedInstance] getTutorsWithName:self.nameField.text course:self.courseField.text andDateAvailable:self.dateField.text];
    
   // TutorProfileViewController *tutor = [[TutorProfileViewController alloc] init];
    //[otherNavController pushViewController:tutor animated:NO];
    
    //TutorSearchResultsViewController *results = [[TutorSearchResultsViewController alloc] init];
    //results.possibleTutors = tutors;
    
    TutorSearchResultsViewController *test = [[TutorSearchResultsViewController alloc] init];
    
    
  
    [self.view addSubview:test.view];
    
    
   // [otherNavController pushViewController:test animated:NO];
}


- (IBAction)dateChanged:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    
    //TODO: Change formatting of string to match how we are storing it in the web service
    self.dateField.text = [NSString stringWithFormat:@"%@", picker.date];
}

- (IBAction)doneEditing:(id)sender {
    [self.dateField resignFirstResponder];
}
@end




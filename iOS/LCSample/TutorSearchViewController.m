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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tutorsUpdated) name:@"TutorsUpdated" object:nil];
        
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

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
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
    NSLog(@"name: %@",self.nameField.text);
    
    [[DBInteract sharedInstance] getTutorsWithName:self.nameField.text course:self.courseField.text andDateAvailable:self.dateField.text];
    

}

-(void)tutorsUpdated {
    NSMutableArray *tutors = [NSMutableArray alloc];
    tutors = [[DBInteract sharedInstance] possibleTutors];
    
    TutorSearchResultsViewController *results = [[TutorSearchResultsViewController alloc] init];
    results.possibleTutors = tutors;
    
    [self.navigationController pushViewController:results animated:YES];
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




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
    
    
    [[DBInteract sharedInstance] getTutorsWithName:self.nameField.text course:self.courseField.text andDateAvailable:self.dateField.text];
    
    
    //    NSLog(@"tutors-->%@",[[DBInteract sharedInstance] getTutorsWithName:self.nameField.text course:self.courseField.text andDateAvailable:self.dateField.text]);
    
    //    @synchronized(self) {
    

}

-(void)tutorsUpdated {
    NSLog(@"possibilites: %@",[[[[DBInteract sharedInstance] possibleTutors] objectAtIndex:0] name]);
    NSMutableArray *tutors = [NSMutableArray alloc];
    tutors = [[DBInteract sharedInstance] possibleTutors];
    //    }
    
    // TutorProfileViewController *tutor = [[TutorProfileViewController alloc] init];
    //[otherNavController pushViewController:tutor animated:NO];
    
    TutorSearchResultsViewController *results = [[TutorSearchResultsViewController alloc] init];
    results.possibleTutors = tutors;
    
//    [self.view.window.rootViewController presentModalViewController:results animated:NO];
    
    [self.view addSubview:results.view];
    
//    UINavigationController *otherNavController = (UINavigationController *)[[self.tabBarController viewControllers] objectAtIndex:0];
//    [otherNavController pushViewController:results animated:NO];
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




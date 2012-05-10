//
//  TutorProfileViewController.m
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import "TutorProfileViewController.h"

@implementation TutorProfileViewController
@synthesize majorsLabel,titleLabel,yearLabel,emailLabel,pictureFrame, tutor;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Tutor Profile" ,@"Tutor Profile");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coursesUpdated) name:@"CoursesUpdated" object:nil];
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
    [titleLabel setText:tutor.name];
    [majorsLabel setText:[NSString stringWithFormat :@"Major: %@",tutor.major]];
    [yearLabel setText:[NSString stringWithFormat :@"Class: %@",tutor.year]];
    [emailLabel setText:tutor.email];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: tutor.image_url]];
    pictureFrame.image = [UIImage imageWithData: imageData];
    [imageData release];
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


-(void)setTutor:(Tutor *)tutorEntered
{
    tutor = tutorEntered;
}


-(IBAction)donePressed:(id)sender 
{
    
    [self.view removeFromSuperview];
    
}
-(IBAction)getSchedulePressed:(id)sender
{
//    [[DBInteract sharedInstance] getCoursesTutoredByName:tutor.idNumber]; 
    //[[DBInteract sharedInstance] getTutorsWithName:self.nameField.text course:self.courseField.text andDateAvailable:self.dateField.text];
    
    [self presentModalViewController:[TutorScheduleViewController alloc] animated:YES];
}

-(IBAction)contactPressed:(id)sender
{
      Course *c1 = [tutor.courses_tutored objectAtIndex:0];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Title", nil)
                                                    message: c1.courseNumber
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)coursesUpdated {
    
    NSMutableArray *courses = [NSMutableArray alloc];
    courses = [[DBInteract sharedInstance] currentCoursesTutored];
    
    tutor.courses_tutored = courses;
    
   
}



@end

//
//  TutorSearchResultsViewController.m
//  LCSample
//
//  Created by Ian Cundiff on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import "TutorSearchResultsViewController.h"

@implementation TutorSearchResultsViewController

@synthesize possibleTutors;

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

-(IBAction)donePressed:(id)sender 
{    
    [self.view removeFromSuperview];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [possibleTutors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
    }
    
    // Set up the cell...
    NSString *cellValue = [[possibleTutors objectAtIndex:indexPath.row] name];
    cell.textLabel.text = cellValue;
    
//    NSLog(@"cell: %@")
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *nameEntered = cell.textLabel.text;
    Tutor *tutor;
    
   
    for (int i =0; i <[possibleTutors count]; i++){
        tutor = (Tutor *)[possibleTutors objectAtIndex:i];
        if ([tutor.name isEqualToString:nameEntered]){
            break;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    TutorProfileViewController *profileView = [TutorProfileViewController alloc];
    [profileView setTutor:tutor]; 
    
       
    [self presentModalViewController:profileView animated:NO];
    
}






@end

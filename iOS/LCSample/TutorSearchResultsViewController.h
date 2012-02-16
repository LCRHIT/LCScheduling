//
//  TutorSearchResultsViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorSearchResultsViewController : UITableViewController <UITableViewDataSource, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *possibleTutors;

-(IBAction)donePressed:(id)sender; 

@end

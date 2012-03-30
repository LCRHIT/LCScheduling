//
//  TutorSearchResultsViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tutor.h"
#import "TutorProfileViewController.h"

@interface TutorSearchResultsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *possibleTutors;




@end

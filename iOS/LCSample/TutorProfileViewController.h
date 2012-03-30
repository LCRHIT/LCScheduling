//
//  TutorProfileViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tutor.h"
#import "DBInteract.h"
#import "Course.h"
#import "TutorScheduleViewController.h"



@interface TutorProfileViewController : UIViewController
{
    Tutor *tutor;
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *majorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *pictureFrame;

-(void)setTutor:(Tutor *)tutorEntered;
-(IBAction)getSchedulePressed:(id)sender;
-(IBAction)contactPressed:(id)sender;

-(void)coursesUpdated; 
@end

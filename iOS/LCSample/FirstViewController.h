//
//  FirstViewController.h
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <RestKit/RestKit.h>
#import "LCAuth.h"
#import "Tutor.h"

@interface FirstViewController : UIViewController <UIAlertViewDelegate>

@property(strong, nonatomic) Tutor *sampleTutor;

- (IBAction)tutorButtonPressed:(id)sender;

@end

//
//  AppDelegate.h
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Support/JSON/JSONKit/RKJSONParserJSONKit.h>
#import "Tutor.h"
#import "LCAuth.h"
#import "LCArgs.h"
#import "Auth_Result.h"
#import "KerberosAccountManager.h"
#import "HomeViewController.h"
#import "TutorSearchViewController.h"
#import "ScheduleViewController.h"
#import "ContactViewController.h"
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectContext *context;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) Tutor *sampleTutor;

//-(NSString *)returnMD5Hash:(NSString*)concat;  this may come in handy...import this to use it: <CommonCrypto/CommonDigest.h>

@end

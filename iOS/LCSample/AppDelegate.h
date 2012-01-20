//
//  AppDelegate.h
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Tutor.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,UIAlertViewDelegate, RKObjectLoaderDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectContext *context;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) Tutor *sampleTutor;

-(NSString *)returnMD5Hash:(NSString*)concat;

@end

//
//  AppDelegate.m
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize context;
@synthesize sampleTutor;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //context = [[UIApplication delegate] managedObjectContext];
    
    //TODO: only populate the tab bar controller if the login screen returns true
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HomeViewController *viewController1 = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    TutorSearchViewController *viewController2 = [[TutorSearchViewController alloc] initWithNibName:@"TutorSearchViewController" bundle:nil];
    ScheduleViewController *viewController3 = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:nil];
    ContactViewController *viewController4 = [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
    //TutorProfileViewController *viewController5 = [[TutorProfileViewController alloc] initWithNibName:@"TutorProfileViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController shouldAutorotateToInterfaceOrientation:UIInterfaceOrientationPortrait];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    LoginViewController *loginView = [LoginViewController alloc];
    //[self.window.rootViewController presentModalViewController:loginView animated:NO];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3, viewController4, nil];
    [self.window.rootViewController.view setNeedsDisplay];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}




/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end

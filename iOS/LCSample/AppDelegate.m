//
//  AppDelegate.m
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "ThirdViewController.h"

#import "FourthViewController.h"

//#import <RestKit/RestKit.h>

#import </Users/ian/Desktop/LCSample 2/RestKit/Code/Support/Parsers/JSON/RKJSONParserJSONKit.h>

#import "LCAuth.h"
#import "Auth_Result.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize context;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //context = [[UIApplication delegate] managedObjectContext];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    UIViewController *viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    UIViewController *viewController3 = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
    UIViewController *viewController4 = [[FourthViewController alloc] initWithNibName:@"FourthViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3, viewController4, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
//    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"];
//    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
//    objectManager.router = router;
//    
//    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"SampleModel.sqlite"];
//    
//    RKManagedObjectMapping* authMapping = [RKManagedObjectMapping mappingForClass:[LCAuth class]];
//    [authMapping mapAttributes:@"username", @"password", nil];
//    [objectManager.mappingProvider setMapping:authMapping forKeyPath:@"lcauth"];
//    
//    [router routeClass:[LCAuth class] toResourcePath:@"/rest/login" forMethod:RKRequestMethodPOST];
//    
//    LCAuth* auth = [LCAuth object];
//    auth.username = @"bamberad";
//    auth.password = [self returnMD5Hash:@"password"];
//    
//    
//    [[RKObjectManager sharedManager] postObject:auth mapResponseWith:authMapping delegate:self];  
    
//    [RKClient clientWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"];
//    
//    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:@"bamberad", @"username",@"passowrd",[self returnMD5Hash:@"password"], nil];
//    RKRequest *req = [[RKClient sharedClient] post:@"/rest/login" params:params delegate:self];
//    
//    NSLog(@"Req: %d\n",req.isPOST);
    
    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"];
    
    
    RKObjectMapping* authSerializationMapping = [RKObjectMapping mappingForClass:[LCAuth class] ];
    [authSerializationMapping mapAttributes:@"username", @"password", nil];
    
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    
    // Now register the mapping with the provider
    [manager.mappingProvider setSerializationMapping:authSerializationMapping forClass:[LCAuth class] ];
    [manager setSerializationMIMEType:RKMIMETypeJSON]; 
    
    
    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
    [router routeClass:[LCAuth class] toResourcePath:@"/rest/login" forMethod:RKRequestMethodPOST];
    
//    [router routeClass:[Auth_Result class] toResourcePath:@"/rest/login" forMethod:RKRequestMethodGET];  
    
    manager.router = router;
    
    RKObjectMapping* authMapping = [RKObjectMapping mappingForClass:[LCAuth class]];
    [authMapping mapKeyPath:@"username" toAttribute:@"username"];
    [authMapping mapKeyPath:@"password" toAttribute:@"password"];
    [authMapping mapKeyPath:@"result" toAttribute:@"LCAuthResult"];
    [authMapping mapKeyPath:@"token" toAttribute:@"LCAuthToken"];
    
    [manager.mappingProvider setMapping:authMapping forKeyPath:@"login"];
    
    RKObjectMapping* resultMapping = [RKObjectMapping mappingForClass:[Auth_Result class]];
    [resultMapping mapKeyPath:@"result" toAttribute:@"LCAuthResult"];
    [resultMapping mapKeyPath:@"token" toAttribute:@"LCAuthToken"];
    
    [manager.mappingProvider setMapping:resultMapping forKeyPath:@"auth_result"];
    
    LCAuth *auth = [LCAuth new];
    auth.username = @"bamberad";
    auth.password = [self returnMD5Hash:@"password"];
    //RKObjectMapping* authMap = [manager.mappingProvider objectMappingForClass:[Auth_Result class] ];
    [manager postObject:auth mapResponseWith:authMapping delegate:self];
//    NSLog(@"reponse: %@", ((LCAuth*)response.sourceObject).username);
    
    
    
    NSLog(@"reponse: %@", auth.result);
    
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"POST successful"
//                                                        message:((Auth_Result*)response.result.asObject). delegate:self 
//                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
    
//    Auth_Result *auth_result = [Auth_Result new];
//    auth_result.result = nil;
//    auth_result.token = nil;
//    [manager getObject:auth_result delegate:self];
//    
//    NSLog(@"result: %@",auth_result.result);
    
//    RKClient* client = [RKClient clientWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"];  
//    RKRequest *request = [client get:@"/rest/login/auth_result.json" delegate:self]; 
//    
//    NSLog(@"request: %d",request.isGET);
    
    
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

//generate md5 hash from string
-(NSString *) returnMD5Hash:(NSString*)concat {
    const char *concat_str = [concat UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSLog(@"eeeerror: %@",error);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    NSLog(@"loaded objects");
//    NSLog(@"objects: %@",objects);
}

//what made the call
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object {
    NSLog(@"loaded object");
//    NSLog(@"object: %@",((LCAuth*)object).username);
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    NSLog(@"unexpected response...");
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

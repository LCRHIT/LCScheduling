//
//  FirstViewController.m
//  LCSample
//
//  Created by Ian Cundiff on 11/1/11.
//  Copyright (c) 2011 Rose-Hulman. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home");
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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
//    [router routeClass:[LCAuth class] toResourcePath:@"/rest/login" forMethod:RKRequestMethodPUT];
//    
//    LCAuth* auth = [LCAuth object];
//    auth.username = @"bamberad";
//    auth.password = [self returnMD5Hash:@"password"];
//    
//    
//    [[RKObjectManager sharedManager] putObject:auth delegate:self];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}





@end

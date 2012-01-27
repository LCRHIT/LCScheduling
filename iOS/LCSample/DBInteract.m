//
//  DBInteract.m
//  LCSample
//
//  Created by Ian Cundiff on 1/24/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//
//  Handles all database connections
//

#import "DBInteract.h"

@implementation DBInteract

@synthesize possibleTutors, schedule;


- (id) init
{
    if ( self = [super init] )
    {
        //initialization code
    }
    return self;
}

+ (id) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


/**
 TODO: Get the tutors (plural) that fit the given criteria from the server and return them as an array...
 **/
-(NSMutableArray*)getTutorsWithName:(NSString*)name course:(NSString*)course andDateAvailable:(NSString*)date {
    
    //initialize object manager with url of web service
    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"];
    
    //set serlialization for each type of object    
    RKObjectMapping* argSerializationMapping = [RKObjectMapping mappingForClass:[LCArgs class] ];
    [argSerializationMapping mapAttributes:@"LCTutorName", nil];
    
    RKObjectMapping* tutorSerializationMapping = [RKObjectMapping mappingForClass:[Tutor class] ];
    [tutorSerializationMapping mapAttributes:@"name", @"year", @"major", @"email", nil];

    
    //set parser to JSON for "text/html" in case it comes in that way
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    
    //register the mappings with the object managers mapping provider
    [manager.mappingProvider setSerializationMapping:argSerializationMapping forClass:[LCArgs class]];
    [manager.mappingProvider setSerializationMapping:tutorSerializationMapping forClass:[Tutor class]];
    
    //let the manager know what MIME type to look out for
    [manager setSerializationMIMEType:RKMIMETypeJSON]; 
    
    //create a router and set it to specific routes on the website for given request types
    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
    [router routeClass:[LCArgs class] toResourcePath:@"/rest/get_tutors_by_name" forMethod:RKRequestMethodPOST];  
    manager.router = router;
    
    //create mappings for the specific attributes of the objects
    RKObjectMapping *argMap = [RKObjectMapping mappingForClass:[LCArgs class]];
    [argMap mapKeyPath:@"LCTutorName" toAttribute:@"LCTutorName"];
    [manager.mappingProvider setMapping:argMap forKeyPath:@"get_tutors_by_name"];
    
    RKObjectMapping *tutorMapping = [RKObjectMapping mappingForClass:[Tutor class]];
    [tutorMapping mapKeyPath:@"name" toAttribute:@"name"];
    [tutorMapping mapKeyPath:@"year" toAttribute:@"year"];
    [tutorMapping mapKeyPath:@"major" toAttribute:@"major"];
    [tutorMapping mapKeyPath:@"email" toAttribute:@"email"]; //attribute means in the objc class
    //one for schedule in the future
    [manager.mappingProvider setMapping:tutorMapping forKeyPath:@"get_tutors_by_name"];

    //create the object to post and post it with an appropriate object mapping
    LCArgs *args = [LCArgs new];
    args.LCTutorName = @"Ian";
    
    Tutor *demoTutor = [Tutor new];
    demoTutor.name = @"Ian";
    
    [manager loadObjectsAtResourcePath:@"/rest/get_tutors_by_name" delegate:self];
    
//    [manager postObject:args mapResponseWith:argMap delegate:self];
    
    
    return possibleTutors;
}

/**
 TODO: Get today's schedule and return it as a schedule object
 **/
-(Schedule*)getScheduleForDate:(NSString*)date {
    return schedule;
}

//generate md5 hash from string...not currently used
//-(NSString *) returnMD5Hash:(NSString*)concat {
//    const char *concat_str = [concat UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(concat_str, strlen(concat_str), result);
//    NSMutableString *hash = [NSMutableString string];
//    for (int i = 0; i < 16; i++)
//        [hash appendFormat:@"%02X", result[i]];
//    return [hash lowercaseString];
//}

#pragma mark ObjectLoaderDelegate methods 

//TODO: handle problems and such here
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSLog(@"error: %@",error);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    //    NSLog(@"loaded objects %@",((Auth_Result*)[objects objectAtIndex:1]).token);
    NSLog(@"objects: %@",objects);
}

//what made the call
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object {
    //    NSLog(@"Auth_Result.token = %@",((LCAuth*)object).username);
    //    NSLog(@"object: %@",((LCAuth*)object).username);
    NSLog(@"object loaded: %@\n",object);
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    NSLog(@"unexpected response...");
}

//TODO: extend this so that it handles different types of responses...
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
    
//    NSMutableArray *tutors;
//    RKJSONParserJSONKit* parser = [RKJSONParserJSONKit new]; 
//    tutors =    [parser objectFromString:[response bodyAsString]]; 
    
//    Tutor *tempTutor = [Tutor new];
//    tempTutor.name = [[response parsedBody:NULL] objectForKey:@"name"];
//    tempTutor.year = [[response parsedBody:NULL] objectForKey:@"year"];
//    tempTutor.email = [[response parsedBody:NULL] objectForKey:@"email"];
//    tempTutor.major = [[response parsedBody:NULL] objectForKey:@"major"];
//    
//    NSLog(@"year: %@\n",tempTutor.year);
//    
//    [possibleTutors addObject:tempTutor];
}

- (void)request:(RKRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    NSLog(@"sent body data %d",totalBytesWritten);
}

@end

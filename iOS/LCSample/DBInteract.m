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

@synthesize possibleTutors;


- (id) init
{
    if ( self = [super init] )
    {
        //initialization code
    }
    return self;
}


/**
 TODO: Get the tutors (plural) that fit the given criteria from the server and return them as an array...
 **/
-(NSMutableArray*)getTutorsWithName:(NSString*)name course:(NSString*)course andDateAvailable:(NSString*)date {
    
    //initialize object manager with url of web service
    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"];
    
    //set serlialization for each type of object
    RKObjectMapping* authSerializationMapping = [RKObjectMapping mappingForClass:[LCAuth class] ];
    [authSerializationMapping mapAttributes:@"username", @"password", nil];
    
    RKObjectMapping* argSerializationMapping = [RKObjectMapping mappingForClass:[LCArgs class] ];
    [argSerializationMapping mapAttributes:@"LCTutorID", nil];
    
    //set parser to JSON for "text/html" in case it comes in that way
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    
    //register the mappings with the object managers mapping provider
    [manager.mappingProvider setSerializationMapping:authSerializationMapping forClass:[LCAuth class] ];
    [manager.mappingProvider setSerializationMapping:argSerializationMapping forClass:[LCArgs class] ];
    
    //let the manager know what MIME type to look out for
    [manager setSerializationMIMEType:RKMIMETypeJSON]; 
    
    //create a router and set it to specific routes on the website for given request types
    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
    [router routeClass:[LCArgs class] toResourcePath:@"/rest/get_tutor_by_id" forMethod:RKRequestMethodPOST];  
    manager.router = router;
    
    //create mappings for the specific attributes of the objects
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
    
    RKObjectMapping *argMap = [RKObjectMapping mappingForClass:[LCArgs class]];
    [argMap mapKeyPath:@"TutorID" toAttribute:@"TutorID"];
    [manager.mappingProvider setMapping:argMap forKeyPath:@"get_tutor_by_id"];
    
    //create the object to post and post it with an appropriate object mapping
    LCArgs *args = [LCArgs new];
    args.LCTutorID = @"1";
    [manager postObject:args mapResponseWith:argMap delegate:self];
    
    return possibleTutors;
}

/**
 TODO: Get today's schedule and return it as a schedule object
 **/
-(Schedule*)getScheduleForDate:(NSString*)date {
    
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
    //    NSLog(@"objects: %@",objects);
}

//what made the call
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object {
    //    NSLog(@"Auth_Result.token = %@",((LCAuth*)object).username);
    //    NSLog(@"object: %@",((LCAuth*)object).username);
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    NSLog(@"unexpected response...");
}

//TODO: extend this so that it handles different types of responses...
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
    
//    sampleTutor = [Tutor new];
//    
//    sampleTutor.name = [[response parsedBody:NULL] objectForKey:@"name"];
//    sampleTutor.year = [[response parsedBody:NULL] objectForKey:@"year"];
//    sampleTutor.email = [[response parsedBody:NULL] objectForKey:@"email"];
//    sampleTutor.major = [[response parsedBody:NULL] objectForKey:@"major"];
}

@end

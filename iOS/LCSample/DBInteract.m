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

int done = 0;

@synthesize possibleTutors, schedule,currentCoursesTutored;


- (id) init
{
    
    if ( self = [super init] )
    {
        
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
    responseType = 1;
    
    //initialize object manager with url of web service
    RKObjectManager *manager = [[RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"] retain];
    
    //set serlialization for each type of object    
    RKObjectMapping* argSerializationMapping = [RKObjectMapping mappingForClass:[LCArgs class] ];
    [argSerializationMapping mapAttributes:@"LCTutorName", @"LCCourseNumber", nil];
    
    RKObjectMapping* tutorSerializationMapping = [RKObjectMapping mappingForClass:[Tutor class] ];
    [tutorSerializationMapping mapAttributes:@"name", @"year", @"major", @"email", nil];
    
    
    //set parser to JSON for "text/html" in case it comes in that way
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    
    //register the mappings with the object managers mapping provider
    [manager.mappingProvider setSerializationMapping:argSerializationMapping forClass:[LCArgs class]];
    [manager.mappingProvider setSerializationMapping:tutorSerializationMapping forClass:[Tutor class]];
    
    //let the manager know what MIME type to look out for
    [manager setSerializationMIMEType:RKMIMETypeJSON]; 
    
//    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
//    [router routeClass:[LCArgs class] toResourcePath:@"/rest/get_tutors_by_name" forMethod:RKRequestMethodPOST]; 

    
    //create the object to post and post it with an appropriate object mapping 
    LCArgs *args = [LCArgs new];
    if (name.length != 0 || course.length != 0) {
        if (name.length != 0) {
            RKObjectRouter* router = [[RKObjectRouter new] autorelease];
            [router routeClass:[LCArgs class] toResourcePath:@"/rest/get_tutors_by_name" forMethod:RKRequestMethodPOST];  
            manager.router = router;
            args.LCTutorName = name;
        }
        if (course.length != 0) {
            RKObjectRouter* router = [[RKObjectRouter new] autorelease];
            [router routeClass:[LCArgs class] toResourcePath:@"/rest/get_tutors_by_course" forMethod:RKRequestMethodPOST]; 
            manager.router = router;
            args.LCCourseNumber = course;
        }
        
        if (name.length != 0 && course.length != 0) {
            RKObjectRouter* router = [[RKObjectRouter new] autorelease];
            [router routeClass:[LCArgs class] toResourcePath:@"/rest/get_tutors_by_name_and_course" forMethod:RKRequestMethodPOST]; 
            manager.router = router;
        }
        
        
        NSArray *postArray = [NSArray arrayWithObjects:manager, args, nil];
        [self performSelectorInBackground:@selector(postWithArray:) withObject:postArray];
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Please enter at least one search term!"
                                                          message:nil
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    }
    
    return possibleTutors;
    
}

-(NSMutableArray*)getCoursesTutoredByName:(NSString*)name {
    responseType = 2;
  
    //initialize object manager with url of web service
    RKObjectManager *manager = [[RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"] retain];
    
    //set serlialization for each type of object    
    RKObjectMapping* argSerializationMapping = [RKObjectMapping mappingForClass:[LCArgs class] ];
    [argSerializationMapping mapAttributes:@"LCTutorID", nil];
    
    RKObjectMapping* courseSerializationMapping = [RKObjectMapping mappingForClass:[Course class] ];
    [courseSerializationMapping mapAttributes:@"department", @"course_number", @"course_description",nil];
    
    //set parser to JSON for "text/html" in case it comes in that way
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    
    //register the mappings with the object managers mapping provider
    [manager.mappingProvider setSerializationMapping:argSerializationMapping forClass:[LCArgs class]];
    [manager.mappingProvider setSerializationMapping:courseSerializationMapping forClass:[Course class]];
    
    //let the manager know what MIME type to look out for
    [manager setSerializationMIMEType:RKMIMETypeJSON]; 
    
    //create a router and set it to specific routes on the website for given request types
    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
    [router routeClass:[LCArgs class] toResourcePath:@"/rest/get_tutor_courses_tutored" forMethod:RKRequestMethodPOST];  
    manager.router = router;
    
    
    
    //create the object to post and post it with an appropriate object mapping
    LCArgs *args = [LCArgs new];
    args.LCTutorName = name;
    
    
    NSArray *postArray = [NSArray arrayWithObjects:manager, args, nil];
    
    //@synchronized(self) {  
//    [self performSelectorInBackground:@selector(postWithArray:) withObject:postArray];
    [self postWithArray:postArray];
    //}
    
    //    [self postWithArray:postArray];
    
    //this is making postObject sleep too...
    
    //    [manager performSelectorOnMainThread:@selector(postObject:delegate:) withObject:args withObject:self waitUntilDone:YES];
   
    
    
    return currentCoursesTutored;
    
}

-(void)authenticateWithCredentials:(LCAuth *)credentials {
    responseType = 3;
    
    //initialize object manager with url of web service
    RKObjectManager *manager = [[RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"] retain];

    RKObjectMapping* auth = [RKObjectMapping mappingForClass:[LCAuth class]];
    [auth mapAttributes:@"username", @"password", nil];
    
    
    //set parser to JSON for "text/html" in case it comes in that way
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    
    //register the mappings with the object managers mapping provider
    [manager.mappingProvider setSerializationMapping:auth forClass:[LCAuth class]];
    
    //let the manager know what MIME type to look out for
    [manager setSerializationMIMEType:RKMIMETypeJSON]; 
    
    //create a router and set it to specific routes on the website for given request types
    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
    [router routeClass:[LCAuth class] toResourcePath:@"/rest/authenticate" forMethod:RKRequestMethodPOST];   
    manager.router = router;
    
    
    NSArray *postArray = [NSArray arrayWithObjects:manager, credentials, nil];
    
    [self performSelectorInBackground:@selector(postWithArray:) withObject:postArray];

    
}

-(void)bookTutorByName:(NSString*) name andTimeslot: (Timeslot *) timeslot {
    responseType = 4;
    
    //initialize object manager with url of web service
    RKObjectManager *manager = [[RKObjectManager objectManagerWithBaseURL:@"http://lcwebapp.csse.rose-hulman.edu"] retain];
    
    RKObjectMapping* auth = [RKObjectMapping mappingForClass:[LCBooking
 class]];
    [auth mapAttributes:@"name", @"timeslot", nil];
    
    
    //set parser to JSON for "text/html" in case it comes in that way
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    
    //register the mappings with the object managers mapping provider
    [manager.mappingProvider setSerializationMapping:auth forClass:[LCBooking class]];
    
    //let the manager know what MIME type to look out for
    [manager setSerializationMIMEType:RKMIMETypeJSON]; 
    
    //create a router and set it to specific routes on the website for given request types
    RKObjectRouter* router = [[RKObjectRouter new] autorelease];
    [router routeClass:[LCAuth class] toResourcePath:@"/rest/authenticate" forMethod:RKRequestMethodPOST];   
    manager.router = router;
    
    
    LCBooking *args = [LCBooking new];
    args.name = name;
    args.timeslot = timeslot;
    
    
    NSArray *postArray = [NSArray arrayWithObjects:manager, args, nil];
    
    [self performSelectorInBackground:@selector(postWithArray:) withObject:postArray];
    
    
}

-(void)postWithArray:(NSArray*)array {
    [[array objectAtIndex:0] postObject:[array objectAtIndex:1] delegate:self];
}

/**
 TODO: Get today's schedule and return it as a schedule object
 **/
-(Schedule*)getScheduleForDate:(NSString*)date {
    return schedule;
}

#pragma mark ObjectLoaderDelegate methods 

//TODO: handle problems and such here
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    //    NSLog(@"error: %@",error);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    //    NSLog(@"loaded objects %@",((Auth_Result*)[objects objectAtIndex:1]).token);
    //    NSLog(@"objects: %@",objects);
}

//what made the call
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObject:(id)object {
    //    NSLog(@"Auth_Result.token = %@",((LCAuth*)object).username);
    //    NSLog(@"object: %@",((LCAuth*)object).username);
    //    NSLog(@"object loaded: %@\n",object);
}

- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader {
    //    NSLog(@"unexpected response...");
}

//TODO: extend this so that it handles different types of responses...
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    //@synchronized(self) {
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
    
    possibleTutors = [[NSMutableArray alloc] init];
    
    
    //put everything from the response into an array
    
    
    //handle stuff based on response type
    if (responseType ==1){
        NSArray *tutors = [NSArray alloc];
        RKJSONParserJSONKit* parser = [RKJSONParserJSONKit new]; 
        tutors = [parser objectFromString:[response bodyAsString] error:NULL];
    
        NSLog(@"object from string: %@",[parser objectFromString:[response bodyAsString] error:NULL]);
    
        for(int i = 0; i < tutors.count; i++) {
            NSLog(@"in for loop\n");
            //make a new tutor
            Tutor *tempTutor = [Tutor new];
            tempTutor.tid = [[tutors valueForKey:@"TID"] objectAtIndex:i];
            tempTutor.name = [[tutors valueForKey:@"name"] objectAtIndex:i];
            tempTutor.year = [[tutors valueForKey:@"year"] objectAtIndex:i];
            tempTutor.email = [[tutors valueForKey:@"email"] objectAtIndex:i];
            tempTutor.major = [[tutors valueForKey:@"major"] objectAtIndex:i];
            tempTutor.image_url = [[tutors valueForKey:@"image_url"] objectAtIndex:i];
            tempTutor.email = [tempTutor.tid stringByAppendingString:@"@rose-hulman.edu"]; 
            

            [possibleTutors addObject:tempTutor];
            NSLog(@"possible tutors: %@",[[possibleTutors objectAtIndex:i] name]);
        }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TutorsUpdated" object:nil];
    
    }
    
    else if (responseType == 2){
        
        //TODO: wipe the list of current courses here
        NSArray *courses = [NSArray alloc];
        RKJSONParserJSONKit* parser = [RKJSONParserJSONKit new]; 
        courses = [parser objectFromString:[response bodyAsString] error:NULL];
        
        NSLog(@"object from string: %@",[parser objectFromString:[response bodyAsString] error:NULL]);
        
        for(int i = 0; i < courses.count; i++) {
            NSLog(@"in for loop\n");
            //make a new course
            Course *tempCourse = [Course new];
            tempCourse.department = [[courses valueForKey:@"department"] objectAtIndex:i];
            tempCourse.courseNumber = [[courses valueForKey:@"course_number"] objectAtIndex:i];
            tempCourse.courseDescription = [[courses valueForKey:@"course_description"] objectAtIndex:i];
            
            //add the course to the array
            [currentCoursesTutored addObject:tempCourse];
            
        }
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CoursesUpdated" object:nil];
    }
    
    else if (responseType == 3) {
        
        NSLog(@"Body as string: %@",[response bodyAsString]);
        
        if ([[response bodyAsString] isEqual:@"true"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
        } else
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginFailure" object:nil];
    }
    
    
    
    
}

- (void)request:(RKRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    //    NSLog(@"sent body data %d",totalBytesWritten);
}

@end

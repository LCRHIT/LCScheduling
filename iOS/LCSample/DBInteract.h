//
//  DBInteract.h
//  LCSample
//
//  Created by Ian Cundiff on 1/24/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/Support/JSON/JSONKit/RKJSONParserJSONKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Support/JSON/JSONKit/JSONKit.h>
#import "LCArgs.h"
#import "LCArgsAlt.h"
#import "LCAuth.h"
#import "Auth_Result.h"
#import "Tutor.h"
#import "Schedule.h"
#import "TestAuth.h"
#import "Timeslot.h"
#import "LCBooking.h"

@interface DBInteract : NSObject <RKObjectLoaderDelegate, RKRequestDelegate>{
    
    int responseType;
    //1 for tutor search, 2 for courses tutored lookup, 3 for schedule lookup
    //ghetto but (hopefully) effective
}

@property(strong, nonatomic) NSMutableArray *possibleTutors;
@property(strong, nonatomic) NSMutableArray *currentCoursesTutored;
@property(strong, nonatomic) Schedule *schedule;

-(NSMutableArray*)getTutorsWithName:(NSString*)name course:(NSString*)course andDateAvailable:(NSString*)date; //TODO: consider changing this to an NSDate...

-(NSMutableArray*)getCoursesTutoredByName:(NSString*)name; 

-(void)authenticateWithCredentials:(LCAuth*)credentials; //consider bool

-(Schedule*)getScheduleForDate:(NSString*)date; //same concern as previous method

-(void)postWithArray:(NSArray*)args;

+ (id)sharedInstance;


@end

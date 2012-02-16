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
#import "LCAuth.h"
#import "Auth_Result.h"
#import "Tutor.h"
#import "Schedule.h"
#include "Semaphore.h"

@interface DBInteract : NSObject <RKObjectLoaderDelegate, RKRequestDelegate>

@property(strong, nonatomic) NSMutableArray *possibleTutors;
@property(strong, nonatomic) Schedule *schedule;

-(NSMutableArray*)getTutorsWithName:(NSString*)name course:(NSString*)course andDateAvailable:(NSString*)date; //TODO: consider changing this to an NSDate...

-(Schedule*)getScheduleForDate:(NSString*)date; //same concern as previous method

-(void)postWithArray:(NSArray*)args;

+ (id)sharedInstance;


@end

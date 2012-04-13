//
//  LCBooking.h
//  LearningCenter
//
//  Created by Ian Cundiff on 4/12/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Timeslot.h"

@interface LCBooking : NSObject

@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) Timeslot* timeslot;


@end

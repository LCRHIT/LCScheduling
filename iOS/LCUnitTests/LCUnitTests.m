//
//  LCUnitTests.m
//  LCUnitTests
//
//  Created by Ian Cundiff on 3/29/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import "LCUnitTests.h"

@implementation LCUnitTests

@synthesize search;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    
    [[DBInteract sharedInstance] getTutorsWithName:@"Ian" course:nil andDateAvailable:nil];
    
    STAssertNotNil([[DBInteract sharedInstance] possibleTutors], @"Looks like possible tutors is nil...");
    
//    STFail(@"Unit tests are not implemented yet in LCUnitTests");
}

@end

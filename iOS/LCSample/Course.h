//
//  Course.h
//  LCSample
//
//  Created by Ian Cundiff on 1/12/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (strong, nonatomic) NSString *department;
@property (strong, nonatomic) NSString *courseNumber;
@property (strong, nonatomic) NSString *courseDescription;

@end

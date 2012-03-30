//
//  Tutor.h
//  LCSample
//
//  Created by Ian Cundiff on 1/12/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface Tutor : NSObject

@property (strong, nonatomic) NSString *idNumber;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *major;
@property (strong, nonatomic) NSString *pictureURL;
@property (strong, nonatomic) NSMutableArray *coursesTutored;


@end

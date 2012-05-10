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

@property (strong, nonatomic) NSString *tid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *major;
@property (strong, nonatomic) NSString *image_url;
@property (strong, nonatomic) NSMutableArray *courses_tutored;
@property (strong, nonatomic) NSString *about_tutor;


@end

//
//  Student.h
//  LCSample
//
//  Created by Ian Cundiff on 1/12/12.
//  Copyright (c) 2012 Rose-Hulman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Student : NSObject

@property (nonatomic, retain) NSString* username;
@property (nonatomic, retain) NSString* password;

@end

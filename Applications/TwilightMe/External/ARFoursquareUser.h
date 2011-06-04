//
//  ARFoursquareUser.h
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ARFoursquareUser : NSObject
{
	NSString *email;
	NSString *password;
	NSString *userID;
	NSString *firstName;
	NSString *lastName;
	NSString *photo;
	
	BOOL isLoggedIn;
}

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *photo;

@property (nonatomic) BOOL isLoggedIn;

@end

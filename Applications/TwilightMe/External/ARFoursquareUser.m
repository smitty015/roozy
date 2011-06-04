//
//  ARFoursquareUser.m
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "ARFoursquareUser.h"


@implementation ARFoursquareUser

@synthesize email, password, isLoggedIn, userID, firstName, lastName, photo;

- (id) init
{
	if(self = [super init])
	{
		isLoggedIn = NO;
	}
	
	return self;
}

@end

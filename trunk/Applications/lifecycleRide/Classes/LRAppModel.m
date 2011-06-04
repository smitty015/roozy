//
//  LRAppModel.m
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "LRAppModel.h"


@implementation LRAppModel

static LRAppModel *instance;

@synthesize context, facebook;

#pragma mark -
#pragma mark Singleton

+ (LRAppModel *) sharedModel
{
	if(!instance)
	{
		instance = [[LRAppModel alloc] init];
		instance.facebook = [[Facebook alloc] initWithAppId:@"139843792741931"];
	}
	
	return instance;
}

- (LRUser *) user
{
	if(!user)
	{
		// Get the current user from core data
		NSFetchRequest *req = [[NSFetchRequest alloc] init];
		
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"LRUser" inManagedObjectContext:self.context];
		[req setEntity:entity];
		
		NSArray *users = [self.context executeFetchRequest:req error:NULL];
		[req release];
		
		if([users count] == 0)
		{
			// Create a new blank user
			user = [NSEntityDescription insertNewObjectForEntityForName:@"LRUser" inManagedObjectContext:self.context];
			[self.context save:NULL];
		}
		else
		{
			user = [users objectAtIndex:0];
		}
		
		[user retain];
	}
	
	return user;
}

@end

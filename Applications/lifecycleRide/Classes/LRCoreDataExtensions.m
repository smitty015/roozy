//
//  LRCoreDataExtensions.m
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "LRCoreDataExtensions.h"
#import "LRRide.h"
#import "LRAppModel.h"


#pragma mark -
#pragma mark LRUser

@implementation LRUser (CoreDataExtensions)

- (int) totalMiles
{
	int count = 0;
	LRRide *ride;
	for(ride in self.rides)
	{
		count += [ride.miles intValue];
	}
	
	return count;
}

- (int) totalIndoorMiles
{
	int count = 0;
	LRRide *ride;
	for(ride in self.rides)
	{
		if([ride.isIndoor isEqualToNumber:[NSNumber numberWithBool:YES]]) count += [ride.miles intValue];
	}
	
	return count;
}

- (int) totalOutdoorMiles
{
	int count = 0;
	LRRide *ride;
	for(ride in self.rides)
	{
		if([ride.isIndoor isEqualToNumber:[NSNumber numberWithBool:NO]]) count += [ride.miles intValue];
	}
	
	return count;
}

- (NSArray *) sortedRides
{
	NSSortDescriptor *descriptor = [[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] autorelease];
	NSArray *descriptors = [[[NSArray alloc] initWithObjects:descriptor, nil] autorelease];
	
	return [[self.rides allObjects] sortedArrayUsingDescriptors:descriptors];
}

- (LRRide *) addNewRideWithMiles:(int)miles date:(NSDate *)date isIndoor:(BOOL)isIndoor
{
	LRRide *ride = [NSEntityDescription insertNewObjectForEntityForName:@"LRRide" inManagedObjectContext:[LRAppModel sharedModel].context];
	ride.miles = [NSNumber numberWithInt:miles];
	ride.date = date;
	ride.isIndoor = [NSNumber numberWithBool:isIndoor];
	
	[self addRidesObject:ride];
	[[LRAppModel sharedModel].context save:NULL];
	
	return ride;
}

@end

#pragma mark -
#pragma mark LRRide

@implementation LRRide (CoreDataExtensions)

@end

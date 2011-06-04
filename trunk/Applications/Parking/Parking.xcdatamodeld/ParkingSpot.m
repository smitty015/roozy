// 
//  ParkingSpot.m
//  Parking
//
//  Created by Andy Roth on 2/8/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ParkingSpot.h"
#import "ParkingAppDelegate.h"


@implementation ParkingSpot 

@dynamic moveBy;
@dynamic longitude;
@dynamic latitude;

- (CLLocationCoordinate2D) coordinate
{
	return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
	self.latitude = [NSNumber numberWithDouble:newCoordinate.latitude];
	self.longitude = [NSNumber numberWithDouble:newCoordinate.longitude];
	[((ParkingAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext save:NULL];
}

- (NSString *) title
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"'Move by' EEE, h:mm a"];
	NSString *result = [formatter stringFromDate:self.moveBy];
	[formatter release];
	
	return result;
}

@end

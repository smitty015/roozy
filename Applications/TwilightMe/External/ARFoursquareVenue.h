//
//  ARFoursquareVenue.h
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ARFoursquareVenue : NSObject
{
	NSString *venueID;
	NSString *name;
	NSString *address;
	NSString *city;
	NSString *state;
	NSString *zip;
	NSString *latitude;
	NSString *longitude;
	NSString *distance;
}

@property (nonatomic, retain) NSString *venueID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *distance;

@end

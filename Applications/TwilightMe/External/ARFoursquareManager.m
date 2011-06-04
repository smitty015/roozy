//
//  ARFoursquareManager.m
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "ARFoursquareManager.h"
#import "ARXMLNode.h"
#import "ARFoursquareUser.h"
#import "ARFoursquareGetVenuesCall.h"
#import "ARFoursquareVenue.h"


@implementation ARFoursquareManager

static ARFoursquareManager *manager;

@synthesize delegate, currentUser;

#pragma mark Singleton Method

+ (ARFoursquareManager *) managerWithDelegate:(NSObject <ARFoursquareManagerDelegate> *)delegate
{
	if(manager == nil)
	{
		manager = [[ARFoursquareManager alloc] init];
		manager.delegate = delegate;
	}
	
	return manager;
}

+ (ARFoursquareManager *) manager
{
	if(manager == nil)
	{
		manager = [[ARFoursquareManager alloc] init];
	}
	
	return manager;
}

#pragma mark Login

- (void) loginWithEmail:(NSString *)email password:(NSString *)password
{
	if(self.currentUser && self.currentUser.isLoggedIn)
	{
		if([delegate respondsToSelector:@selector(foursquare:didLoginWithUserData:)]) [delegate foursquare:self didLoginWithUserData:self.currentUser];
		return;
	}
	
	self.currentUser = [[ARFoursquareUser alloc] init];
	self.currentUser.email = email;
	self.currentUser.password = password;
	
	ARFoursquareLoginCall *loginCall = [[ARFoursquareLoginCall alloc] init];
	[loginCall executeWithDelegate:self];
}

- (void) loginCallSucceededWithResponse:(NSArray *)response
{
	ARXMLNode *rootNode = [response objectAtIndex:0];
	
	// Parse the results into the user object
	self.currentUser.userID = [rootNode getChildNodeByName:@"id"].content;
	self.currentUser.firstName = [rootNode getChildNodeByName:@"firstname"].content;
	self.currentUser.lastName = [rootNode getChildNodeByName:@"lastname"].content;
	self.currentUser.photo = [rootNode getChildNodeByName:@"photo"].content;
	
	if([delegate respondsToSelector:@selector(foursquare:didLoginWithUserData:)]) [delegate foursquare:self didLoginWithUserData:self.currentUser];
}

- (void) loginCallFailed
{
	[delegate foursquare:self didFailWithMessage:@"Login failed."];
}

#pragma mark Get Venues

- (void) getNearbyVenues
{
	ARFoursquareGetVenuesCall *getVenuesCall = [[ARFoursquareGetVenuesCall alloc] init];
	[getVenuesCall executeWithDelegate:self];
}

- (void) getVenuesCallSucceededWithResponse:(NSArray *)response
{
	ARXMLNode *rootNode = [response objectAtIndex:0];
	ARXMLNode *groupNode = [rootNode getChildNodeByName:@"group"];
	
	NSMutableArray *nearbyVenues = [[NSMutableArray alloc] init];
	
	ARXMLNode *venueNode;
	for(venueNode in groupNode.children)
	{
		ARFoursquareVenue *venue = [[ARFoursquareVenue alloc] init];
		
		venue.venueID = [venueNode getChildNodeByName:@"id"].content;
		venue.name = [venueNode getChildNodeByName:@"name"].content;
		venue.address = [venueNode getChildNodeByName:@"address"].content;
		venue.city = [venueNode getChildNodeByName:@"city"].content;
		venue.state = [venueNode getChildNodeByName:@"state"].content;
		venue.zip = [venueNode getChildNodeByName:@"zip"].content;
		venue.latitude = [venueNode getChildNodeByName:@"geolat"].content;
		venue.longitude = [venueNode getChildNodeByName:@"geolong"].content;
		venue.distance = [venueNode getChildNodeByName:@"distance"].content;
		
		[nearbyVenues addObject:venue];
	}
	
	if([delegate respondsToSelector:@selector(foursquare:didReceiveNearbyVenues:)]) [delegate foursquare:self didReceiveNearbyVenues:nearbyVenues];
}

- (void) getVenuesCallFailed
{
	[delegate foursquare:self didFailWithMessage:@"Get venues failed."];
}

#pragma mark Checkins

- (void) checkinToVenueWithID:(NSString *)vid
{
	[self checkinToVenueWithID:vid shoutMessage:nil];
}

- (void) shoutAMessage:(NSString *)message
{
	[self checkinToVenueWithID:nil shoutMessage:message];
}

- (void) checkinToVenueWithID:(NSString *)vid shoutMessage:(NSString *)message
{
	ARFoursquareCheckinCall *checkinCall = [[ARFoursquareCheckinCall alloc] init];
	[checkinCall executeWithDelegate:self venueID:vid shoutMessage:message];
}

- (void) checkinCallSucceededWithResponse:(NSArray *)response
{
	ARXMLNode *rootNode = [response objectAtIndex:0];
	NSString *message = [rootNode getChildNodeByName:@"message"].content;
	
	if([delegate respondsToSelector:@selector(foursquare:didCheckinWithMessage:)]) [delegate foursquare:self didCheckinWithMessage:message];
}

- (void) checkinCallFailed
{
	[delegate foursquare:self didFailWithMessage:@"Checkin failed."];
}

@end

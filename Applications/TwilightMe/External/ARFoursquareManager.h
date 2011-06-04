//
//  ARFoursquareManager.h
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARFoursquareUser.h"
#import "ARFoursquareLoginCall.h"
#import "ARFoursquareGetVenuesCall.h"
#import "ARFoursquareVenue.h"
#import "ARFoursquareCheckinCall.h"

@class ARFoursquareManager;

@protocol ARFoursquareManagerDelegate

- (void) foursquare:(ARFoursquareManager *)manager didFailWithMessage:(NSString *)message;

@optional

- (void) foursquare:(ARFoursquareManager *)manager didLoginWithUserData:(ARFoursquareUser *)user;
- (void) foursquare:(ARFoursquareManager *)manager didReceiveNearbyVenues:(NSArray *)venues;
- (void) foursquare:(ARFoursquareManager *)manager didCheckinWithMessage:(NSString *)message;

@end


@interface ARFoursquareManager : NSObject <ARFoursquareLoginCallDelegate, ARFoursquareGetVenuesCallDelegate, ARFoursquareCheckinCallDelegate>
{
	NSObject <ARFoursquareManagerDelegate> *delegate;
	ARFoursquareUser *currentUser;
}

@property (nonatomic, retain) NSObject <ARFoursquareManagerDelegate> *delegate;
@property (nonatomic, retain) ARFoursquareUser *currentUser;

+ (ARFoursquareManager *) managerWithDelegate:(NSObject <ARFoursquareManagerDelegate> *) delegate;
+ (ARFoursquareManager *) manager;

- (void) loginWithEmail:(NSString *)email password:(NSString *)password;
- (void) getNearbyVenues;
- (void) checkinToVenueWithID:(NSString *)vid;
- (void) checkinToVenueWithID:(NSString *)vid shoutMessage:(NSString *)message;
- (void) shoutAMessage:(NSString *)message;

@end

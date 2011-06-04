//
//  ARFoursquareGetVenuesCall.h
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class ARFoursquareGetVenuesCall;

@protocol ARFoursquareGetVenuesCallDelegate

- (void) getVenuesCallSucceededWithResponse:(NSArray *)response;
- (void) getVenuesCallFailed;

@end

@interface ARFoursquareGetVenuesCall : NSObject <CLLocationManagerDelegate>
{
	id <ARFoursquareGetVenuesCallDelegate> delegate;
	NSMutableData *_webData;
}

@property (nonatomic, retain) id <ARFoursquareGetVenuesCallDelegate> delegate;

- (void) executeWithDelegate:(id <ARFoursquareGetVenuesCallDelegate>)callDelegate;
- (void) sendRequestWithLatitude:(NSString *)latitude longitude:(NSString *)longitude;

@end

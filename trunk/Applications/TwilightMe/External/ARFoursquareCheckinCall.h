//
//  ARFoursquareCheckinCall.h
//  CommonLibraries
//
//  Created by Andrew Roth on 3/16/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ARFoursquareCheckinCallDelegate

- (void) checkinCallSucceededWithResponse:(NSArray *)response;
- (void) checkinCallFailed;

@end

@interface ARFoursquareCheckinCall : NSObject
{
	id <ARFoursquareCheckinCallDelegate> delegate;
	NSMutableData *_webData;
}

@property (nonatomic, retain) id <ARFoursquareCheckinCallDelegate> delegate;

- (void) executeWithDelegate:(id <ARFoursquareCheckinCallDelegate>)callDelegate venueID:(NSString *)vid shoutMessage:(NSString *)message;

@end

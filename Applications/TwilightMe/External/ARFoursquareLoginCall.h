//
//  ARFoursquareLoginCall.h
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARFoursquareLoginCall;

@protocol ARFoursquareLoginCallDelegate

- (void) loginCallSucceededWithResponse:(NSArray *)response;
- (void) loginCallFailed;

@end

@interface ARFoursquareLoginCall : NSObject
{
	id <ARFoursquareLoginCallDelegate> delegate;
	NSMutableData *_webData;
}

@property (nonatomic, retain) id <ARFoursquareLoginCallDelegate> delegate;

- (void) executeWithDelegate:(id <ARFoursquareLoginCallDelegate>)callDelegate;

@end

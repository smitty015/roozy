//
//  RIToast.h
//  iLibraryCore
//
//  Created by Andy Roth on 11/19/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum RIToastDuration
{
	RIToastDurationLong,
	RIToastDurationShort
} RIToastDuration;

@interface RIToast : NSObject
{

}

+ (void) showToast:(NSString *)content duration:(RIToastDuration)duration;

@end

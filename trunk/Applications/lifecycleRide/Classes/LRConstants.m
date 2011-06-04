//
//  LRContants.m
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "LRConstants.h"
#import "NSDate-Utilities.h"
#import "LRRide.h"
#import "LRUser.h"
#import "LRAppModel.h"


@implementation LRConstants

+ (float) week1Goal { return 36.0309481165636; }
+ (float) week2Goal { return 40.0343867961818; }
+ (float) week3Goal { return 44.4826519957575; }
+ (float) week4Goal { return 22.2413259978788; }
+ (float) week5Goal { return 49.425168884175; }
+ (float) week6Goal { return 54.91685431575; }
+ (float) week7Goal { return 61.0187270175; }
+ (float) week8Goal { return 30.50936350875; }
+ (float) week9Goal { return 67.798585575; }
+ (float) week10Goal { return 75.33176175; }
+ (float) week11Goal { return 83.7019575; }
+ (float) week12Goal { return 41.85097875; }
+ (float) week13Goal { return 93.002175; }
+ (float) week14Goal { return 103.33575; }
+ (float) week15Goal { return 114.8175; }
+ (float) week16Goal { return 57.40875; }
+ (float) week17Goal { return 127.575; }
+ (float) week18Goal { return 141.75; }
+ (float) week19Goal { return 157.5; }
+ (float) week20Goal { return 78.75; }
+ (float) week21Goal { return 175; }

+ (NSDate *) week1StartDate { return [NSDate dateWithString:@"01/03/11"]; }
+ (NSDate *) week2StartDate { return [NSDate dateWithString:@"01/10/11"]; }
+ (NSDate *) week3StartDate { return [NSDate dateWithString:@"01/17/11"]; }
+ (NSDate *) week4StartDate { return [NSDate dateWithString:@"01/24/11"]; }
+ (NSDate *) week5StartDate { return [NSDate dateWithString:@"01/31/11"]; }
+ (NSDate *) week6StartDate { return [NSDate dateWithString:@"02/07/11"]; }
+ (NSDate *) week7StartDate { return [NSDate dateWithString:@"02/14/11"]; }
+ (NSDate *) week8StartDate { return [NSDate dateWithString:@"02/21/11"]; }
+ (NSDate *) week9StartDate { return [NSDate dateWithString:@"02/28/11"]; }
+ (NSDate *) week10StartDate { return [NSDate dateWithString:@"03/07/11"]; }
+ (NSDate *) week11StartDate { return [NSDate dateWithString:@"03/14/11"]; }
+ (NSDate *) week12StartDate { return [NSDate dateWithString:@"03/21/11"]; }
+ (NSDate *) week13StartDate { return [NSDate dateWithString:@"03/28/11"]; }
+ (NSDate *) week14StartDate { return [NSDate dateWithString:@"04/04/11"]; }
+ (NSDate *) week15StartDate { return [NSDate dateWithString:@"04/11/11"]; }
+ (NSDate *) week16StartDate { return [NSDate dateWithString:@"04/18/11"]; }
+ (NSDate *) week17StartDate { return [NSDate dateWithString:@"04/25/11"]; }
+ (NSDate *) week18StartDate { return [NSDate dateWithString:@"05/02/11"]; }
+ (NSDate *) week19StartDate { return [NSDate dateWithString:@"05/09/11"]; }
+ (NSDate *) week20StartDate { return [NSDate dateWithString:@"05/16/11"]; }
+ (NSDate *) week21StartDate { return [NSDate dateWithString:@"05/23/11"]; }
+ (NSDate *) lastDate { return [NSDate dateWithString:@"05/29/11"]; }

+ (NSDate *) raceStartDate { return [NSDate dateWithString:@"06/05/11"]; }

+ (float)getGoalMiles:(int)index
{
	if (index == 1)
	{
		return [LRConstants week1Goal];
	}
	else if (index == 2)
	{
		return [LRConstants week2Goal];
	}
	else if (index == 3)
	{
		return [LRConstants week3Goal];
	}
	else if (index == 4)
	{
		return [LRConstants week4Goal];
	}
	else if (index == 5)
	{
		return [LRConstants week5Goal];
	}
	else if (index == 6)
	{
		return [LRConstants week6Goal];
	}
	else if (index == 7)
	{
		return [LRConstants week7Goal];
	}
	else if (index == 8)
	{
		return [LRConstants week8Goal];
	}
	else if (index == 9)
	{
		return [LRConstants week9Goal];
	}
	else if (index == 10)
	{
		return [LRConstants week10Goal];
	}
	else if (index == 11)
	{
		return [LRConstants week11Goal];
	}
	else if (index == 12)
	{
		return [LRConstants week12Goal];
	}
	else if (index == 13)
	{
		return [LRConstants week13Goal];
	}
	else if (index == 14)
	{
		return [LRConstants week14Goal];
	}
	else if (index == 15)
	{
		return [LRConstants week15Goal];
	}
	else if (index == 16)
	{
		return [LRConstants week16Goal];
	}
	else if (index == 17)
	{
		return [LRConstants week17Goal];
	}
	else if (index == 18)
	{
		return [LRConstants week18Goal];
	}
	else if (index == 19)
	{
		return [LRConstants week19Goal];
	}
	else if (index == 20)
	{
		return [LRConstants week20Goal];
	}
	else // last week so 21
	{
		return [LRConstants week21Goal];
	}
	
}

+ (float)getMilesForWeek:(int)index
{
	if (index == 1)
	{
		return [self milesInWeek:[LRConstants week1StartDate] endDate:[LRConstants week2StartDate]];
	}
	else if (index == 2)
	{
		return [self milesInWeek:[LRConstants week2StartDate] endDate:[LRConstants week3StartDate]];
	}
	else if (index == 3)
	{
		return [self milesInWeek:[LRConstants week3StartDate] endDate:[LRConstants week4StartDate]];
	}
	else if (index == 4)
	{
		return [self milesInWeek:[LRConstants week4StartDate] endDate:[LRConstants week5StartDate]];
	}
	else if (index == 5)
	{
		return [self milesInWeek:[LRConstants week5StartDate] endDate:[LRConstants week6StartDate]];
	}
	else if (index == 6)
	{
		return [self milesInWeek:[LRConstants week6StartDate] endDate:[LRConstants week7StartDate]];
	}
	else if (index == 7)
	{
		return [self milesInWeek:[LRConstants week7StartDate] endDate:[LRConstants week8StartDate]];
	}
	else if (index == 8)
	{
		return [self milesInWeek:[LRConstants week8StartDate] endDate:[LRConstants week9StartDate]];
	}
	else if (index == 9)
	{
		return [self milesInWeek:[LRConstants week9StartDate] endDate:[LRConstants week10StartDate]];
	}
	else if (index == 10)
	{
		return [self milesInWeek:[LRConstants week10StartDate] endDate:[LRConstants week11StartDate]];
	}
	else if (index == 11)
	{
		return [self milesInWeek:[LRConstants week11StartDate] endDate:[LRConstants week12StartDate]];
	}
	else if (index == 12)
	{
		return [self milesInWeek:[LRConstants week12StartDate] endDate:[LRConstants week13StartDate]];
	}
	else if (index == 13)
	{
		return [self milesInWeek:[LRConstants week13StartDate] endDate:[LRConstants week14StartDate]];
	}
	else if (index == 14)
	{
		return [self milesInWeek:[LRConstants week14StartDate] endDate:[LRConstants week15StartDate]];
	}
	else if (index == 15)
	{
		return [self milesInWeek:[LRConstants week15StartDate] endDate:[LRConstants week16StartDate]];
	}
	else if (index == 16)
	{
		return [self milesInWeek:[LRConstants week16StartDate] endDate:[LRConstants week17StartDate]];
	}
	else if (index == 17)
	{
		return [self milesInWeek:[LRConstants week17StartDate] endDate:[LRConstants week18StartDate]];
	}
	else if (index == 18)
	{
		return [self milesInWeek:[LRConstants week18StartDate] endDate:[LRConstants week19StartDate]];
	}
	else if (index == 19)
	{
		return [self milesInWeek:[LRConstants week19StartDate] endDate:[LRConstants week20StartDate]];
	}
	else if (index == 20)
	{
		return [self milesInWeek:[LRConstants week20StartDate] endDate:[LRConstants week21StartDate]];
	}
	else // last week so 21
	{
		return [self milesInWeek:[LRConstants week21StartDate] endDate:[LRConstants lastDate]];
	}
	
}

+ (float)getIndoorMilesForWeek:(int)index
{
	if (index == 1)
	{
		return [self indoorMilesInWeek:[LRConstants week1StartDate] endDate:[LRConstants week2StartDate]];
	}
	else if (index == 2)
	{
		return [self indoorMilesInWeek:[LRConstants week2StartDate] endDate:[LRConstants week3StartDate]];
	}
	else if (index == 3)
	{
		return [self indoorMilesInWeek:[LRConstants week3StartDate] endDate:[LRConstants week4StartDate]];
	}
	else if (index == 4)
	{
		return [self indoorMilesInWeek:[LRConstants week4StartDate] endDate:[LRConstants week5StartDate]];
	}
	else if (index == 5)
	{
		return [self indoorMilesInWeek:[LRConstants week5StartDate] endDate:[LRConstants week6StartDate]];
	}
	else if (index == 6)
	{
		return [self indoorMilesInWeek:[LRConstants week6StartDate] endDate:[LRConstants week7StartDate]];
	}
	else if (index == 7)
	{
		return [self indoorMilesInWeek:[LRConstants week7StartDate] endDate:[LRConstants week8StartDate]];
	}
	else if (index == 8)
	{
		return [self indoorMilesInWeek:[LRConstants week8StartDate] endDate:[LRConstants week9StartDate]];
	}
	else if (index == 9)
	{
		return [self indoorMilesInWeek:[LRConstants week9StartDate] endDate:[LRConstants week10StartDate]];
	}
	else if (index == 10)
	{
		return [self indoorMilesInWeek:[LRConstants week10StartDate] endDate:[LRConstants week11StartDate]];
	}
	else if (index == 11)
	{
		return [self indoorMilesInWeek:[LRConstants week11StartDate] endDate:[LRConstants week12StartDate]];
	}
	else if (index == 12)
	{
		return [self indoorMilesInWeek:[LRConstants week12StartDate] endDate:[LRConstants week13StartDate]];
	}
	else if (index == 13)
	{
		return [self indoorMilesInWeek:[LRConstants week13StartDate] endDate:[LRConstants week14StartDate]];
	}
	else if (index == 14)
	{
		return [self indoorMilesInWeek:[LRConstants week14StartDate] endDate:[LRConstants week15StartDate]];
	}
	else if (index == 15)
	{
		return [self indoorMilesInWeek:[LRConstants week15StartDate] endDate:[LRConstants week16StartDate]];
	}
	else if (index == 16)
	{
		return [self indoorMilesInWeek:[LRConstants week16StartDate] endDate:[LRConstants week17StartDate]];
	}
	else if (index == 17)
	{
		return [self indoorMilesInWeek:[LRConstants week17StartDate] endDate:[LRConstants week18StartDate]];
	}
	else if (index == 18)
	{
		return [self indoorMilesInWeek:[LRConstants week18StartDate] endDate:[LRConstants week19StartDate]];
	}
	else if (index == 19)
	{
		return [self indoorMilesInWeek:[LRConstants week19StartDate] endDate:[LRConstants week20StartDate]];
	}
	else if (index == 20)
	{
		return [self indoorMilesInWeek:[LRConstants week20StartDate] endDate:[LRConstants week21StartDate]];
	}
	else // last week so 21
	{
		return [self indoorMilesInWeek:[LRConstants week21StartDate] endDate:[LRConstants lastDate]];
	}
	
	
}

+ (float)getOutdoorMilesForWeek:(int)index
{
	if (index == 1)
	{
		return [self outdoorMilesInWeek:[LRConstants week1StartDate] endDate:[LRConstants week2StartDate]];
	}
	else if (index == 2)
	{
		return [self outdoorMilesInWeek:[LRConstants week2StartDate] endDate:[LRConstants week3StartDate]];
	}
	else if (index == 3)
	{
		return [self outdoorMilesInWeek:[LRConstants week3StartDate] endDate:[LRConstants week4StartDate]];
	}
	else if (index == 4)
	{
		return [self outdoorMilesInWeek:[LRConstants week4StartDate] endDate:[LRConstants week5StartDate]];
	}
	else if (index == 5)
	{
		return [self outdoorMilesInWeek:[LRConstants week5StartDate] endDate:[LRConstants week6StartDate]];
	}
	else if (index == 6)
	{
		return [self outdoorMilesInWeek:[LRConstants week6StartDate] endDate:[LRConstants week7StartDate]];
	}
	else if (index == 7)
	{
		return [self outdoorMilesInWeek:[LRConstants week7StartDate] endDate:[LRConstants week8StartDate]];
	}
	else if (index == 8)
	{
		return [self outdoorMilesInWeek:[LRConstants week8StartDate] endDate:[LRConstants week9StartDate]];
	}
	else if (index == 9)
	{
		return [self outdoorMilesInWeek:[LRConstants week9StartDate] endDate:[LRConstants week10StartDate]];
	}
	else if (index == 10)
	{
		return [self outdoorMilesInWeek:[LRConstants week10StartDate] endDate:[LRConstants week11StartDate]];
	}
	else if (index == 11)
	{
		return [self outdoorMilesInWeek:[LRConstants week11StartDate] endDate:[LRConstants week12StartDate]];
	}
	else if (index == 12)
	{
		return [self outdoorMilesInWeek:[LRConstants week12StartDate] endDate:[LRConstants week13StartDate]];
	}
	else if (index == 13)
	{
		return [self outdoorMilesInWeek:[LRConstants week13StartDate] endDate:[LRConstants week14StartDate]];
	}
	else if (index == 14)
	{
		return [self outdoorMilesInWeek:[LRConstants week14StartDate] endDate:[LRConstants week15StartDate]];
	}
	else if (index == 15)
	{
		return [self outdoorMilesInWeek:[LRConstants week15StartDate] endDate:[LRConstants week16StartDate]];
	}
	else if (index == 16)
	{
		return [self outdoorMilesInWeek:[LRConstants week16StartDate] endDate:[LRConstants week17StartDate]];
	}
	else if (index == 17)
	{
		return [self outdoorMilesInWeek:[LRConstants week17StartDate] endDate:[LRConstants week18StartDate]];
	}
	else if (index == 18)
	{
		return [self outdoorMilesInWeek:[LRConstants week18StartDate] endDate:[LRConstants week19StartDate]];
	}
	else if (index == 19)
	{
		return [self outdoorMilesInWeek:[LRConstants week19StartDate] endDate:[LRConstants week20StartDate]];
	}
	else if (index == 20)
	{
		return [self outdoorMilesInWeek:[LRConstants week20StartDate] endDate:[LRConstants week21StartDate]];
	}
	else // last week so 21
	{
		return [self outdoorMilesInWeek:[LRConstants week21StartDate] endDate:[LRConstants lastDate]];
	}
	
	
}

+(float)milesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate
{
	float totalMilesInWeek = 0.0;
	LRUser *user = [LRAppModel sharedModel].user;
	LRRide *ride;
	for (ride in user.rides) 
	{
		if ([ride.date isLaterThanDate:startDate] && [ride.date isEarlierThanDate:endDate])
		{
			totalMilesInWeek = totalMilesInWeek + [ride.miles floatValue];
		}
	}
	return totalMilesInWeek;
}

+ (float)indoorMilesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate
{
	float totalMilesInWeek = 0.0;
	LRUser *user = [LRAppModel sharedModel].user;
	LRRide *ride;
	for (ride in user.rides) 
	{
		if ([ride.date isLaterThanDate:startDate] && [ride.date isEarlierThanDate:endDate])
		{
			if ([ride.isIndoor intValue] == 1)
				totalMilesInWeek = totalMilesInWeek + [ride.miles floatValue];
		}
	}
	return totalMilesInWeek;
	
}

+ (float)outdoorMilesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate
{
	float totalMilesInWeek = 0.0;
	LRUser *user = [LRAppModel sharedModel].user;
	LRRide *ride;
	for (ride in user.rides) 
	{
		if ([ride.date isLaterThanDate:startDate] && [ride.date isEarlierThanDate:endDate])
		{
			if ([ride.isIndoor intValue] == 0)
				totalMilesInWeek = totalMilesInWeek + [ride.miles floatValue];
		}
	}
	return totalMilesInWeek;
	
}

+ (NSArray *)getRidesForWeek:(int)index
{
	if (index == 1)
	{
		return [self ridesInWeek:[LRConstants week1StartDate] endDate:[LRConstants week2StartDate]];
	}
	else if (index == 2)
	{
		return [self ridesInWeek:[LRConstants week2StartDate] endDate:[LRConstants week3StartDate]];
	}
	else if (index == 3)
	{
		return [self ridesInWeek:[LRConstants week3StartDate] endDate:[LRConstants week4StartDate]];
	}
	else if (index == 4)
	{
		return [self ridesInWeek:[LRConstants week4StartDate] endDate:[LRConstants week5StartDate]];
	}
	else if (index == 5)
	{
		return [self ridesInWeek:[LRConstants week5StartDate] endDate:[LRConstants week6StartDate]];
	}
	else if (index == 6)
	{
		return [self ridesInWeek:[LRConstants week6StartDate] endDate:[LRConstants week7StartDate]];
	}
	else if (index == 7)
	{
		return [self ridesInWeek:[LRConstants week7StartDate] endDate:[LRConstants week8StartDate]];
	}
	else if (index == 8)
	{
		return [self ridesInWeek:[LRConstants week8StartDate] endDate:[LRConstants week9StartDate]];
	}
	else if (index == 9)
	{
		return [self ridesInWeek:[LRConstants week9StartDate] endDate:[LRConstants week10StartDate]];
	}
	else if (index == 10)
	{
		return [self ridesInWeek:[LRConstants week10StartDate] endDate:[LRConstants week11StartDate]];
	}
	else if (index == 11)
	{
		return [self ridesInWeek:[LRConstants week11StartDate] endDate:[LRConstants week12StartDate]];
	}
	else if (index == 12)
	{
		return [self ridesInWeek:[LRConstants week12StartDate] endDate:[LRConstants week13StartDate]];
	}
	else if (index == 13)
	{
		return [self ridesInWeek:[LRConstants week13StartDate] endDate:[LRConstants week14StartDate]];
	}
	else if (index == 14)
	{
		return [self ridesInWeek:[LRConstants week14StartDate] endDate:[LRConstants week15StartDate]];
	}
	else if (index == 15)
	{
		return [self ridesInWeek:[LRConstants week15StartDate] endDate:[LRConstants week16StartDate]];
	}
	else if (index == 16)
	{
		return [self ridesInWeek:[LRConstants week16StartDate] endDate:[LRConstants week17StartDate]];
	}
	else if (index == 17)
	{
		return [self ridesInWeek:[LRConstants week17StartDate] endDate:[LRConstants week18StartDate]];
	}
	else if (index == 18)
	{
		return [self ridesInWeek:[LRConstants week18StartDate] endDate:[LRConstants week19StartDate]];
	}
	else if (index == 19)
	{
		return [self ridesInWeek:[LRConstants week19StartDate] endDate:[LRConstants week20StartDate]];
	}
	else if (index == 20)
	{
		return [self ridesInWeek:[LRConstants week20StartDate] endDate:[LRConstants week21StartDate]];
	}
	else // last week so 21
	{
		return [self ridesInWeek:[LRConstants week21StartDate] endDate:[LRConstants lastDate]];
	}
	
	
}

+ (NSArray *)ridesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate
{
	NSMutableArray *ridesForWeek = [[[NSMutableArray alloc] init] retain];
	LRUser *user = [LRAppModel sharedModel].user;
	LRRide *ride;
	for (ride in user.rides) 
	{
		if ([ride.date isLaterThanDate:startDate] && [ride.date isEarlierThanDate:endDate])
		{
			[ridesForWeek addObject:ride];
		}
	}
	return ridesForWeek;
}


@end

//
//  LRContants.h
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LRConstants : NSObject
{

}

+ (float) week1Goal;
+ (float) week2Goal;
+ (float) week3Goal;
+ (float) week4Goal;
+ (float) week5Goal;
+ (float) week6Goal;
+ (float) week7Goal;
+ (float) week8Goal;
+ (float) week9Goal;
+ (float) week10Goal;
+ (float) week11Goal;
+ (float) week12Goal;
+ (float) week13Goal;
+ (float) week14Goal;
+ (float) week15Goal;
+ (float) week16Goal;
+ (float) week17Goal;
+ (float) week18Goal;
+ (float) week19Goal;
+ (float) week20Goal;
+ (float) week21Goal;

+ (NSDate *) week1StartDate;
+ (NSDate *) week2StartDate;
+ (NSDate *) week3StartDate;
+ (NSDate *) week4StartDate;
+ (NSDate *) week5StartDate;
+ (NSDate *) week6StartDate;
+ (NSDate *) week7StartDate;
+ (NSDate *) week8StartDate;
+ (NSDate *) week9StartDate;
+ (NSDate *) week10StartDate;
+ (NSDate *) week11StartDate;
+ (NSDate *) week12StartDate;
+ (NSDate *) week13StartDate;
+ (NSDate *) week14StartDate;
+ (NSDate *) week15StartDate;
+ (NSDate *) week16StartDate;
+ (NSDate *) week17StartDate;
+ (NSDate *) week18StartDate;
+ (NSDate *) week19StartDate;
+ (NSDate *) week20StartDate;
+ (NSDate *) week21StartDate;
+ (NSDate *) lastDate;

+ (NSDate *) raceStartDate;

+ (float)getGoalMiles:(int)index;
+ (float)getMilesForWeek:(int)index;
+ (float)getIndoorMilesForWeek:(int)index;
+ (float)getOutdoorMilesForWeek:(int)index;
+(float)milesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (float)indoorMilesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (float)outdoorMilesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (NSArray *)getRidesForWeek:(int)index;
+ (NSArray *)ridesInWeek:(NSDate *)startDate endDate:(NSDate *)endDate;

@end

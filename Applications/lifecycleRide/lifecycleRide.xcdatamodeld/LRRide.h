//
//  LRRide.h
//  lifecycleRide
//
//  Created by Andy Roth on 1/18/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <CoreData/CoreData.h>

@class LRUser;

@interface LRRide :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * miles;
@property (nonatomic, retain) NSNumber * elevation;
@property (nonatomic, retain) NSNumber * averageSpeed;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * hoursElapsed;
@property (nonatomic, retain) NSNumber * minutesElapsed;
@property (nonatomic, retain) NSNumber * isIndoor;
@property (nonatomic, retain) LRUser * user;

@end




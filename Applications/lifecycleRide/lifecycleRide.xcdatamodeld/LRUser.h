//
//  LRUser.h
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <CoreData/CoreData.h>

@class LRRide;

@interface LRUser :  NSManagedObject  
{
}

@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet* rides;

@end


@interface LRUser (CoreDataGeneratedAccessors)
- (void)addRidesObject:(LRRide *)value;
- (void)removeRidesObject:(LRRide *)value;
- (void)addRides:(NSSet *)value;
- (void)removeRides:(NSSet *)value;

@end


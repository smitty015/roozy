//
//  ParkingSpot.h
//  Parking
//
//  Created by Andy Roth on 2/8/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>


@interface ParkingSpot :  NSManagedObject <MKAnnotation>
{
}

@property (nonatomic, retain) NSDate * moveBy;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;

@end




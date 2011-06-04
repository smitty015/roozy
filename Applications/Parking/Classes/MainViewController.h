//
//  MainViewController.h
//  Parking
//
//  Created by Andy Roth on 2/8/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ParkingSpot.h"
#import "InputViewController.h"


@interface MainViewController : UIViewController <MKMapViewDelegate, InputViewDelegate>
{
	IBOutlet MKMapView *mapView;
	ParkingSpot *currentSpot;
	NSManagedObjectContext *context;
	
	BOOL mapRegionSet;
}

@property (nonatomic, retain) NSManagedObjectContext *context;

- (void) reloadCurrentSpot;
- (IBAction) clear;
- (IBAction) update;

@end

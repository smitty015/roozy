//
//  MainViewController.m
//  Parking
//
//  Created by Andy Roth on 2/8/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "MainViewController.h"
#import "InputViewController.h"


@implementation MainViewController

@synthesize context;

#pragma mark -
#pragma mark Initialization

- (void) viewDidLoad
{
	[self reloadCurrentSpot];
}

- (void) reloadCurrentSpot
{
	// Remove the current spot if it exists
	if(currentSpot)
	{
		[mapView removeAnnotation:currentSpot];
		[currentSpot release];
		currentSpot = nil;
	}
	
	// Get the current parking spot
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"ParkingSpot" inManagedObjectContext:self.context];
	[req setEntity:entity];
	NSArray *spots = [self.context executeFetchRequest:req error:NULL];
	[req release];
	
	if([spots count] != 0)
	{
		currentSpot = [[spots objectAtIndex:0] retain];
		
		// Map the spot
		[mapView addAnnotation:currentSpot];
		[mapView setRegion:MKCoordinateRegionMake(currentSpot.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
	}
}

- (void) inputDidSave
{
	[self reloadCurrentSpot];
}

#pragma mark -
#pragma mark Button Actions

- (IBAction) clear
{
	if(currentSpot)
	{
		[mapView removeAnnotation:currentSpot];
		[self.context deleteObject:currentSpot];
		[currentSpot release];
		currentSpot = nil;
		
		[self.context save:NULL];
	}
}

- (IBAction) update
{
	if(mapView.userLocation)
	{
		InputViewController *input = [[InputViewController alloc] init];
		input.coord = mapView.userLocation.coordinate;
		input.context = self.context;
		input.delegate = self;
		
		[self presentModalViewController:input animated:YES];
		[input release];
	}
}

#pragma mark -
#pragma mark Map Delegate

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if(annotation == mapView.userLocation) return nil;
	
	MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ParkingSpot"];
	pin.canShowCallout = YES;
	pin.draggable = YES;
	pin.animatesDrop = YES;
	return pin;
}

- (void)mapView:(MKMapView *)aMapVew didUpdateUserLocation:(MKUserLocation *)userLocation
{
	if(!currentSpot && !mapRegionSet)
	{
		mapRegionSet = YES;
		
		[mapView setRegion:MKCoordinateRegionMake(mapView.userLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01))];
	}
}

#pragma mark -
#pragma mark Cleanup

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

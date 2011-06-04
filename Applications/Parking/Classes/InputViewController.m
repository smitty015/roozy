//
//  InputViewController.m
//  Parking
//
//  Created by Andy Roth on 2/8/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "InputViewController.h"
#import "ParkingSpot.h"


@implementation InputViewController

@synthesize delegate, coord, context;

- (IBAction) cancel
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction) save
{
	// Save the current location
	NSDate *date = datePicker.date;
	
	NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setDateFormat:@"h:mm a"];
	NSString *timeString = [timeFormatter stringFromDate:date];
	[timeFormatter release];
	
	NSString *dayString = @"Mon";
	
	switch (dayPicker.selectedSegmentIndex)
	{
		case 1:
			dayString = @"Tue";
			break;
		case 2:
			dayString = @"Wed";
			break;
		case 3:
			dayString = @"Thu";
			break;
		case 4:
			dayString = @"Fri";
			break;
		default:
			break;
	}
	
	NSDateFormatter *overallFormatter = [[NSDateFormatter alloc] init];
	[overallFormatter setDateFormat:@"EEE h:mm a"];
	NSDate *newDate = [overallFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", dayString, timeString]];
	[overallFormatter release];
	
	// Get the current parking spot
	NSFetchRequest *req = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"ParkingSpot" inManagedObjectContext:self.context];
	[req setEntity:entity];
	NSArray *spots = [self.context executeFetchRequest:req error:NULL];
	[req release];
	
	ParkingSpot *spot;
	if([spots count] != 0)
	{
		spot = [[spots objectAtIndex:0] retain];
	}
	else
	{
		spot = [NSEntityDescription insertNewObjectForEntityForName:@"ParkingSpot" inManagedObjectContext:self.context];
	}
	
	spot.latitude = [NSNumber numberWithDouble:coord.latitude];
	spot.longitude = [NSNumber numberWithDouble:coord.longitude];
	spot.moveBy = newDate;
	
	// Dismiss
	[self.parentViewController dismissModalViewControllerAnimated:YES];
	[delegate inputDidSave];
}

#pragma mark -
#pragma mark Cleanup

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[self.context release];
    [super dealloc];
}


@end

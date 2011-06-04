//
//  InputDataViewController.m
//  lifecycleRide
//
//  Created by Suzy Smith on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputDataViewController.h"
#import "LRAppModel.h"
#import "LRUser.h"
#import "LRRide.h"
#import "RideDateViewController.h"
#import "LRCoreDataExtensions.h"
#import "FBConnect.h"

@implementation InputDataViewController

@synthesize delegate, cameFromOtherTimeField, rideDate;

- (void) dateWasPicked:(NSDate *)date
{
	rideDate = date;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy"];
	dateOfRide.text = [formatter stringFromDate:rideDate]; 
}

- (void)viewDidLoad 
{
	cameFromOtherTimeField = NO;
	
	[indoorToggle setImages:[UIImage imageNamed:@"radioButtonSelected.png"] offImage:[UIImage imageNamed:@"radioButtonUnselected.png"]];
	[outdoorToggle setImages:[UIImage imageNamed:@"radioButtonSelected.png"] offImage:[UIImage imageNamed:@"radioButtonUnselected.png"]];
	
	ARToggleButtonGroup *g = [[ARToggleButtonGroup alloc] initWithButtons:[NSArray arrayWithObjects:indoorToggle, outdoorToggle, nil]];
	[outdoorToggle setOn:YES];
}

-(IBAction) dateButton
{
	RideDateViewController *rideDateViewController = [[RideDateViewController alloc] init];
	rideDateViewController.delegate = self;
	[self presentModalViewController:rideDateViewController animated:YES];
	
	[rideDateViewController release];

}

-(IBAction) cancel
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction) save
{
	// Miles - from text to number
	NSNumber *milesToSave = [NSNumber numberWithInt:[milesRode.text intValue]];
	// Outdoor
	NSNumber *isIndoorBool;
	if (outdoorToggle.on)
	{
		isIndoorBool = [NSNumber numberWithInt:0];
	}
	else 
	{
		isIndoorBool = [NSNumber numberWithInt:1];
	}
	// Time - hours and minutes
	NSNumber *hoursToSave = [NSNumber numberWithInt:[rideTimeHours.text intValue]];
	NSNumber *minsToSave = [NSNumber numberWithInt:[rideTimeMinutes.text intValue]];
	// Avg Speed
	NSNumber *avgSpeedToSave = [NSNumber numberWithInt:[avgSpeedOfRide.text intValue]];
	// Share on FB

	LRRide *existingRide = [self getExistingRideForDate:rideDate];
	if (existingRide != nil)
	{
		// Ride for day already exists, modify and save
		existingRide.miles = milesToSave;
		existingRide.date = rideDate;
		existingRide.isIndoor = isIndoorBool;
		existingRide.hoursElapsed = hoursToSave;
		existingRide.minutesElapsed = minsToSave;
		existingRide.averageSpeed = avgSpeedToSave;
		[[LRAppModel sharedModel].context save:NULL];
	}
	else 
	{
		// No ride for date yet, save new
		LRRide *newRide = [[LRAppModel sharedModel].user addNewRideWithMiles:0 date:rideDate isIndoor:NO];
		newRide.miles = milesToSave;
		newRide.isIndoor = isIndoorBool;
		newRide.hoursElapsed = hoursToSave;
		newRide.minutesElapsed = minsToSave;
		newRide.averageSpeed = avgSpeedToSave;
		[[LRAppModel sharedModel].context save:NULL];
	}
	
	// If FB share is on, then share on FB
	if (shareOnFB.on)
	{
		LRUser *user = [LRAppModel sharedModel].user;
		
		NSString *milesRodeString = @"I biked ";
		milesRodeString = [milesRodeString stringByAppendingString:milesRode.text];
		milesRodeString = [milesRodeString stringByAppendingString:@" miles."];
		NSString *donateString = @"Please support my participation in AIDS/LifeCycle: ";
		donateString = [donateString stringByAppendingString:user.url];
		
		NSArray *media = [NSArray arrayWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"image", @"type",
												   @"http://www.aidslifecycle.org/assets/images/logo_only_ACL.png", @"src",
												   @"http://www.aidslifecycle.org/", @"href", nil]];
		
		SBJSON *jsonWriter = [[SBJSON new] autorelease];
		
		NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
									@"ALC Training Ride", @"name",
									milesRodeString, @"caption",
									donateString, @"description",
									@"http://www.aidslifecycle.org/", @"href",
									media, @"media", nil];
		NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
		NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									   @"Share on Facebook",  @"user_message_prompt",
									   attachmentStr, @"attachment",
									   nil];
		
		
		[[LRAppModel sharedModel].facebook dialog:@"stream.publish"
				andParams:params
			  andDelegate:nil];
	}
	
	[delegate inputDataViewControllerDidSave];
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (LRRide *)getExistingRideForDate:(NSDate *)dateForRide
{
	// Loop through all rides
	LRUser *user = [LRAppModel sharedModel].user;
	LRRide *ride;
	for (ride in user.rides) 
	{
		// If find one with the date send back to modify
		if ([ride.date isEqualToDate:dateForRide])
			return ride;
	}
	return nil;
}

#pragma mark -
#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == milesRode)
	{
		[rideTimeHours becomeFirstResponder];
	}
	else if (textField == rideTimeHours)
	{
		cameFromOtherTimeField = YES;
		[rideTimeMinutes becomeFirstResponder];
	}
	else if (textField == rideTimeMinutes)
	{
		[avgSpeedOfRide becomeFirstResponder];
	}
	else if(textField == avgSpeedOfRide)
	{
		[avgSpeedOfRide resignFirstResponder];
	}
	
	return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (textField == rideTimeHours || textField == rideTimeMinutes)
	{
		if (!cameFromOtherTimeField)
		{
			[UIView beginAnimations:@"moveView" context:nil];
			contentView.frame = CGRectMake(0, -50, 320, 416);
			[UIView commitAnimations];
			cameFromOtherTimeField = NO;
		}
		else 
		{
			contentView.frame = CGRectMake(0, -50, 320, 416);
			cameFromOtherTimeField = NO;
		}

		// two spinners - hh/mm
	}
	else if (textField == avgSpeedOfRide)
	{
		[UIView beginAnimations:@"moveView" context:nil];
		contentView.frame = CGRectMake(0, -50, 320, 416);
		[UIView commitAnimations];
		// use number keyboard
		
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[UIView beginAnimations:@"moveView" context:nil];
	contentView.frame = CGRectMake(0, 44, 320, 416);
	[UIView commitAnimations];
}


#pragma mark -
#pragma mark Facebook

- (IBAction) facebookShareTapped:(id)sender
{
	if(shareOnFB.on && ![[LRAppModel sharedModel].facebook isSessionValid])
	{
		[[LRAppModel sharedModel].facebook authorize:[NSArray arrayWithObjects:@"publish_stream", @"offline_access", nil] delegate:self];
	}
}

- (void)fbDidLogin
{
	NSLog(@"Logged into Facebook");
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
	shareOnFB.on = NO;
}

- (void)fbDidLogout
{
	shareOnFB.on = NO;
}

#pragma mark -
#pragma mark Cleaup

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
	
	delegate = nil;
	
    [super dealloc];
}


@end

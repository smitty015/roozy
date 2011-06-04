//
//  HomeViewController.m
//  lifecycleRide
//
//  Created by Suzy Smith on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "EditViewController.h"
#import "LRCoreDataExtensions.h"
#import "LRAppModel.h"
#import "LRUser.h"
#import "LRConstants.h"
#import "NSDate-Utilities.h"


@implementation HomeViewController

#pragma mark -
#pragma mark Init

- (void) viewDidLoad
{
	//UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(tappedEdit)];
	
	//self.navigationItem.title = @"ALC 2011";
	//self.navigationItem.rightBarButtonItem = edit;
	//[self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
	
	//[edit release];
	self.navigationController.navigationBar.hidden = YES;
	
	//[self refreshData];
}

- (void) viewWillAppear:(BOOL)animated
{
	[self refreshData];
}

- (void) refreshData
{
	// Set up all the labels and data
	LRUser *user = [LRAppModel sharedModel].user;
	name.text = user.name;
	
	NSDate *currentDate = [NSDate date];
	if ([currentDate isEarlierThanDate:[LRConstants week2StartDate]])
	{
		currentTrainingWeek.text = @"training week 1";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week3StartDate]])
	{
		currentTrainingWeek.text = @"training week 2";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week4StartDate]])
	{
		currentTrainingWeek.text = @"training week 3";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week5StartDate]])
	{
		currentTrainingWeek.text = @"training week 4";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week6StartDate]])
	{
		currentTrainingWeek.text = @"training week 5";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week7StartDate]])
	{
		currentTrainingWeek.text = @"training week 6";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week8StartDate]])
	{
		currentTrainingWeek.text = @"training week 7";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week9StartDate]])
	{
		currentTrainingWeek.text = @"training week 8";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week10StartDate]])
	{
		currentTrainingWeek.text = @"training week 9";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week11StartDate]])
	{
		currentTrainingWeek.text = @"training week 10";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week12StartDate]])
	{
		currentTrainingWeek.text = @"training week 11";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week13StartDate]])
	{
		currentTrainingWeek.text = @"training week 12";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week14StartDate]])
	{
		currentTrainingWeek.text = @"training week 13";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week15StartDate]])
	{
		currentTrainingWeek.text = @"training week 14";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week16StartDate]])
	{
		currentTrainingWeek.text = @"training week 15";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week17StartDate]])
	{
		currentTrainingWeek.text = @"training week 16";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week18StartDate]])
	{
		currentTrainingWeek.text = @"training week 17";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week19StartDate]])
	{
		currentTrainingWeek.text = @"training week 18";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week20StartDate]])
	{
		currentTrainingWeek.text = @"training week 19";
	}
	else if ([currentDate isEarlierThanDate:[LRConstants week21StartDate]])
	{
		currentTrainingWeek.text = @"training week 20";
	}
	else 
	{
		currentTrainingWeek.text = @"training week 21";
	}
	
	if (user.picture != nil)
	{
		imageUsed.image = [[UIImage alloc] initWithData:user.picture];
	}
	
	int daysBeforeRideTotal = [[NSDate date] daysBeforeDate:[LRConstants raceStartDate]];
	daysUntilRide.text = [NSString stringWithFormat:@"%d", daysBeforeRideTotal];
	
	totalMilesLogged.text = [NSString stringWithFormat:@"%d", user.totalMiles];
	indoorMilesLogged.text = [NSString stringWithFormat:@"%d", user.totalIndoorMiles];
	outdoorMilesLogged.text = [NSString stringWithFormat:@"%d", user.totalOutdoorMiles];
}

#pragma mark -
#pragma mark Button Actions

- (IBAction) tappedEdit
{
	EditViewController *editViewController = [[EditViewController alloc] init];
	editViewController.delegate = self;
	[self presentModalViewController:editViewController animated:YES];
	
	[editViewController release];
}

#pragma mark -
#pragma mark Edit View Delegate

- (void) editViewControllerDidSave
{
	[self refreshData];
}

#pragma mark -
#pragma mark Cleanup

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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

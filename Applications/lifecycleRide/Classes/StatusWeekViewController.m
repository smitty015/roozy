//
//  StatusWeekViewController.m
//  lifecycleRide
//
//  Created by Suzy Smith on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatusWeekViewController.h"
#import "LRConstants.h"
#import "LRRide.h"
#import "NSDate-Utilities.h"
#import "LRAppModel.h"


@implementation StatusWeekViewController

@synthesize week;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	self.navigationItem.title = @"ALC 2011";
	self.navigationItem.hidesBackButton = YES;
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
	
	UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
	[backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *customBack = [[UIBarButtonItem alloc] initWithCustomView:backButton];
	self.navigationItem.leftBarButtonItem = customBack;
	
	[self refresh];
}

- (void) refresh
{
	weekNumber.text = [NSString stringWithFormat:@"Week %d", week];
	
	// week of
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"MM.dd"];
	NSDate *startDate = [self getWeekStartDate:week];
	weekStartDate.text = [format stringFromDate:startDate];
	
	// total miles - using for miles/goal
	// Get goals miles
	int goal = [LRConstants getGoalMiles:week];
	int miles = [LRConstants getMilesForWeek:week];
	//int totMiles = [LRConstants getMilesForWeek:week];
	totalMiles.text = [NSString stringWithFormat:@"%d/%d",miles,goal];
	// total indoor miles
	int totIndMiles = [LRConstants getIndoorMilesForWeek:week];
	totalIndoorMiles.text = [NSString stringWithFormat:@"%d",totIndMiles];
	// total outdoor miles
	int totOutMiles = [LRConstants getOutdoorMilesForWeek:week];
	totalOutdoorMiles.text = [NSString stringWithFormat:@"%d",totOutMiles];
	// default all ride information to a "-"
	mondayMiles.text = @"-";
	mondaySpeed.text = @"-";
	mondayTime.text = @"-";
	tuesdayMiles.text = @"-";
	tuesdaySpeed.text = @"-";
	tuesdayTime.text = @"-";
	wednesdayMiles.text = @"-";
	wednesdaySpeed.text = @"-";
	wednesdayTime.text = @"-";
	thursdayMiles.text = @"-";
	thursdaySpeed.text = @"-";
	thursdayTime.text = @"-";
	fridayMiles.text = @"-";
	fridaySpeed.text = @"-";
	fridayTime.text = @"-";
	saturdayMiles.text = @"-";
	saturdaySpeed.text = @"-";
	saturdayTime.text = @"-";
	sundayMiles.text = @"-";
	sundaySpeed.text = @"-";
	sundayTime.text = @"-";
	// get ride data for this week
	NSArray *ridesForWeek = [LRConstants getRidesForWeek:week];
	LRRide *ride;
	for (ride in ridesForWeek)
	{
		// See what day of week it is (sunday = 1)
		[self setRideForDay:ride weekDay:ride.date.weekday];
	}
}

- (void) goBack
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)setRideForDay:(LRRide *)ride weekDay:(int)weekDay
{
	if (weekDay == 1) // Sunday
	{
		sundayMiles.text = [ride.miles stringValue];
		if (!([ride.hoursElapsed intValue] == 0 && [ride.minutesElapsed intValue] == 0))
		{
			sundayTime.text = [NSString stringWithFormat:@"%@:%@",[ride.hoursElapsed stringValue],[ride.minutesElapsed stringValue]];
		}
		if ([ride.averageSpeed intValue] != 0)
		{
			sundaySpeed.text = [ride.averageSpeed stringValue];
		}
	}
	else if (weekDay == 2)
	{
		mondayMiles.text = [ride.miles stringValue];
		if (!([ride.hoursElapsed intValue] == 0 && [ride.minutesElapsed intValue] == 0))
		{
			mondayTime.text = [NSString stringWithFormat:@"%@:%@",[ride.hoursElapsed stringValue],[ride.minutesElapsed stringValue]];
		}
		if ([ride.averageSpeed intValue] != 0)
		{
			mondaySpeed.text = [ride.averageSpeed stringValue];
		}
	}
	else if (weekDay == 3)
	{
		tuesdayMiles.text = [ride.miles stringValue];
		if (!([ride.hoursElapsed intValue] == 0 && [ride.minutesElapsed intValue] == 0))
		{
			tuesdayTime.text = [NSString stringWithFormat:@"%@:%@",[ride.hoursElapsed stringValue],[ride.minutesElapsed stringValue]];
		}
		if ([ride.averageSpeed intValue] != 0)
		{
			tuesdaySpeed.text = [ride.averageSpeed stringValue];
		}
	}
	else if (weekDay == 4)
	{
		wednesdayMiles.text = [ride.miles stringValue];
		if (!([ride.hoursElapsed intValue] == 0 && [ride.minutesElapsed intValue] == 0))
		{
			wednesdayTime.text = [NSString stringWithFormat:@"%@:%@",[ride.hoursElapsed stringValue],[ride.minutesElapsed stringValue]];
		}
		if ([ride.averageSpeed intValue] != 0)
		{
			wednesdaySpeed.text = [ride.averageSpeed stringValue];
		}
	}
	else if (weekDay == 5)
	{
		thursdayMiles.text = [ride.miles stringValue];
		if (!([ride.hoursElapsed intValue] == 0 && [ride.minutesElapsed intValue] == 0))
		{
			thursdayTime.text = [NSString stringWithFormat:@"%@:%@",[ride.hoursElapsed stringValue],[ride.minutesElapsed stringValue]];
		}
		if ([ride.averageSpeed intValue] != 0)
		{
			thursdaySpeed.text = [ride.averageSpeed stringValue];
		}
	}
	else if (weekDay == 6)
	{
		fridayMiles.text = [ride.miles stringValue];
		if (!([ride.hoursElapsed intValue] == 0 && [ride.minutesElapsed intValue] == 0))
		{
			fridayTime.text = [NSString stringWithFormat:@"%@:%@",[ride.hoursElapsed stringValue],[ride.minutesElapsed stringValue]];
		}
		if ([ride.averageSpeed intValue] != 0)
		{
			fridaySpeed.text = [ride.averageSpeed stringValue];
		}
	}
	else if (weekDay == 7)
	{
		saturdayMiles.text = [ride.miles stringValue];
		if (!([ride.hoursElapsed intValue] == 0 && [ride.minutesElapsed intValue] == 0))
		{
			saturdayTime.text = [NSString stringWithFormat:@"%@:%@",[ride.hoursElapsed stringValue],[ride.minutesElapsed stringValue]];
		}
		if ([ride.averageSpeed intValue] != 0)
		{
			saturdaySpeed.text = [ride.averageSpeed stringValue];
		}
	}
}

- (IBAction) tappedDeleteButton:(id)sender
{
	UIButton *button = (UIButton *)sender;
	int tag = button.tag;
	
	[self clearRideForDay:tag];
    [self refresh];
}

- (void) clearRideForDay:(int)weekDay
{
	NSArray *ridesForWeek = [LRConstants getRidesForWeek:week];
	LRRide *ride;
	for (ride in ridesForWeek)
	{
		if(ride.date.weekday == weekDay)
		{
			[[LRAppModel sharedModel].user removeRidesObject:ride];
			[[LRAppModel sharedModel].context deleteObject:ride];
			[[LRAppModel sharedModel].context save:NULL];
		}
	}
}

- (NSDate *)getWeekStartDate:(int)index
{
	if (index == 1)
	{
		return [LRConstants week1StartDate];
	}
	else if (index == 2)
	{
		return [LRConstants week2StartDate];
	}
	else if (index == 3)
	{
		return [LRConstants week3StartDate];
	}
	else if (index == 4)
	{
		return [LRConstants week4StartDate];
	}
	else if (index == 5)
	{
		return [LRConstants week5StartDate];
	}
	else if (index == 6)
	{
		return [LRConstants week6StartDate];
	}
	else if (index == 7)
	{
		return [LRConstants week7StartDate];
	}
	else if (index == 8)
	{
		return [LRConstants week8StartDate];
	}
	else if (index == 9)
	{
		return [LRConstants week9StartDate];
	}
	else if (index == 10)
	{
		return [LRConstants week10StartDate];
	}
	else if (index == 11)
	{
		return [LRConstants week11StartDate];
	}
	else if (index == 12)
	{
		return [LRConstants week12StartDate];
	}
	else if (index == 13)
	{
		return [LRConstants week13StartDate];
	}
	else if (index == 14)
	{
		return [LRConstants week14StartDate];
	}
	else if (index == 15)
	{
		return [LRConstants week15StartDate];
	}
	else if (index == 16)
	{
		return [LRConstants week16StartDate];
	}
	else if (index == 17)
	{
		return [LRConstants week17StartDate];
	}
	else if (index == 18)
	{
		return [LRConstants week18StartDate];
	}
	else if (index == 19)
	{
		return [LRConstants week19StartDate];
	}
	else if (index == 20)
	{
		return [LRConstants week20StartDate];
	}
	else // last week so 21
	{
		return [LRConstants week21StartDate];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

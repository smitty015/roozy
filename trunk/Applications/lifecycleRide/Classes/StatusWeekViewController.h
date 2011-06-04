//
//  StatusWeekViewController.h
//  lifecycleRide
//
//  Created by Suzy Smith on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRRide.h"


@interface StatusWeekViewController : UIViewController 
{
	IBOutlet UILabel *weekNumber;
	IBOutlet UILabel *weekStartDate;
	//IBOutlet UILabel *weekEndDate;
	IBOutlet UILabel *mondayMiles;
	IBOutlet UILabel *mondayTime;
	IBOutlet UILabel *mondaySpeed;
	IBOutlet UILabel *tuesdayMiles;
	IBOutlet UILabel *tuesdayTime;
	IBOutlet UILabel *tuesdaySpeed;
	IBOutlet UILabel *wednesdayMiles;
	IBOutlet UILabel *wednesdayTime;
	IBOutlet UILabel *wednesdaySpeed;
	IBOutlet UILabel *thursdayMiles;
	IBOutlet UILabel *thursdayTime;
	IBOutlet UILabel *thursdaySpeed;
	IBOutlet UILabel *fridayMiles;
	IBOutlet UILabel *fridayTime;
	IBOutlet UILabel *fridaySpeed;
	IBOutlet UILabel *saturdayMiles;
	IBOutlet UILabel *saturdayTime;
	IBOutlet UILabel *saturdaySpeed;
	IBOutlet UILabel *sundayMiles;
	IBOutlet UILabel *sundayTime;
	IBOutlet UILabel *sundaySpeed;
	IBOutlet UILabel *totalMiles;
	IBOutlet UILabel *totalOutdoorMiles;
	IBOutlet UILabel *totalIndoorMiles;
	
	int week;
}

@property (nonatomic) int week;

- (NSDate *)getWeekStartDate:(int)index;
- (void)setRideForDay:(LRRide *)ride weekDay:(int)weekDay;
- (IBAction) tappedDeleteButton:(id)sender;
- (void) clearRideForDay:(int)weekDay;
- (void) refresh;
- (void) goBack;

@end

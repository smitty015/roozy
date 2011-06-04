//
//  InputDataViewController.h
//  lifecycleRide
//
//  Created by Suzy Smith on 1/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRRide.h"
#import "RideDateViewController.h"
#import "Facebook.h"
#import "ARToggleButton.h"
#import "ARToggleButtonGroup.h"

@protocol InputDataViewControllerDelegate

- (void) inputDataViewControllerDidSave;

@end


@interface InputDataViewController : UIViewController <UITextFieldDelegate, DatePickerViewDelegate, FBSessionDelegate, FBDialogDelegate>
{
	id <InputDataViewControllerDelegate> delegate;
	
	IBOutlet UILabel *dateOfRide;
	IBOutlet UIButton *datePickerButton;
	IBOutlet UITextField *milesRode;
	//IBOutlet UISwitch *outdoorBoolean;
	IBOutlet ARToggleButton *indoorToggle;
	IBOutlet ARToggleButton *outdoorToggle;
	IBOutlet UITextField *rideTimeHours;
	IBOutlet UITextField *rideTimeMinutes;
	IBOutlet UITextField *avgSpeedOfRide;
	IBOutlet UISwitch *shareOnFB;
	IBOutlet UIView *contentView;
	
	IBOutlet UIButton *cancel;
	IBOutlet UIButton *save;
	
	NSDate *rideDate;
	
	BOOL cameFromOtherTimeField;

}
@property (nonatomic, assign) id <InputDataViewControllerDelegate> delegate;
@property(nonatomic) BOOL cameFromOtherTimeField;
@property(nonatomic, retain) NSDate *rideDate;

-(IBAction) dateButton;
-(IBAction) cancel;
-(IBAction) save;
- (LRRide *)getExistingRideForDate:(NSDate *)dateForRide;
- (IBAction) facebookShareTapped:(id)sender;

@end

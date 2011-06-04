//
//  RideDateViewController.h
//  lifecycleRide
//
//  Created by Suzy Smith on 1/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate

- (void) dateWasPicked:(NSDate *)date;

@end


@interface RideDateViewController : UIViewController 
{
	id <DatePickerViewDelegate> delegate;
	
	IBOutlet UIDatePicker *dateOfRidePicker;
	IBOutlet UIButton *doneButton;
}
@property (nonatomic, assign) id <DatePickerViewDelegate> delegate;
-(IBAction)done;

@end

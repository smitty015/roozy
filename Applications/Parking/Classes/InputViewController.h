//
//  InputViewController.h
//  Parking
//
//  Created by Andy Roth on 2/8/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol InputViewDelegate

- (void) inputDidSave;

@end


@interface InputViewController : UIViewController
{
	id <InputViewDelegate> delegate;
	
	CLLocationCoordinate2D coord;
	NSManagedObjectContext *context;
	
	IBOutlet UISegmentedControl *dayPicker;
	IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, assign) id <InputViewDelegate> delegate;

@property (nonatomic) CLLocationCoordinate2D coord;
@property (nonatomic, retain) NSManagedObjectContext *context;

- (IBAction) cancel;
- (IBAction) save;

@end

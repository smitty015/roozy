//
//  HomeViewController.h
//  lifecycleRide
//
//  Created by Suzy Smith on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"


@interface HomeViewController : UIViewController <EditViewControllerDelegate>
{
	IBOutlet UILabel	*name;
	IBOutlet UILabel	*currentTrainingWeek;
	IBOutlet UILabel	*daysUntilRide;
	IBOutlet UILabel	*totalMilesLogged;
	IBOutlet UILabel	*indoorMilesLogged;
	IBOutlet UILabel	*outdoorMilesLogged;
	IBOutlet UIImageView	*imageUsed;
	IBOutlet UIButton *editButton;
}

- (void) refreshData;
- (IBAction) tappedEdit;

@end

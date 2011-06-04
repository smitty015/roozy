//
//  StatusViewController.h
//  lifecycleRide
//
//  Created by Suzy Smith on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputDataViewController.h"


@interface StatusViewController : UITableViewController <InputDataViewControllerDelegate>
{
	NSMutableArray *weeks;
}
@property (nonatomic, retain) NSMutableArray *weeks;

- (void) refreshData;

@end

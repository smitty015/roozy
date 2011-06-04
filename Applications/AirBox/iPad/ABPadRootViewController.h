//
//  ABPadRootViewController.h
//  AirBox
//
//  Created by Andy Roth on 2/15/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABPadWebViewController.h"
#import "ABFileTableViewController.h"


@interface ABPadRootViewController : UIViewController
{
	IBOutlet UISplitViewController *rootSplitViewController;
	
	IBOutlet ABPadWebViewController *fileWebViewController;
	IBOutlet ABFileTableViewController *fileTableViewController;
}

- (void) refreshFileList;

@end

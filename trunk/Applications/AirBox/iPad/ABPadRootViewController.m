    //
//  ABPadRootViewController.m
//  AirBox
//
//  Created by Andy Roth on 2/15/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABPadRootViewController.h"
#import "UIView+RIExtended.h"


@implementation ABPadRootViewController

#pragma mark -
#pragma mark Initization

- (void) viewDidLoad
{
	// Customize the view
	fileTableViewController.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
	fileTableViewController.navigationItem.titleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]] autorelease];
	fileTableViewController.delegate = fileWebViewController;
	[fileTableViewController addRefreshButton];
	
	// Set the view to the split view controller
	self.view = rootSplitViewController.view;
	
	// Update the web view
	[self didRotateFromInterfaceOrientation:self.interfaceOrientation];
}

- (void) refreshFileList
{
	[fileTableViewController refreshList];
	[fileWebViewController refreshAirplayDevices];
}

#pragma mark -
#pragma mark Orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Overriden to allow any orientation.
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[fileWebViewController updateViewWithOrientation:self.interfaceOrientation];
}

#pragma mark -
#pragma mark Cleanup

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

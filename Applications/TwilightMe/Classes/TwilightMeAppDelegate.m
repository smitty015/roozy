//
//  TwilightMeAppDelegate.m
//  TwilightMe
//
//  Created by Roth on 11/25/09.
//  Copyright Roozy 2009. All rights reserved.
//

#import "TwilightMeAppDelegate.h"
#import "UIColor+ARExtended.h"

@implementation TwilightMeAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    navController = [[UINavigationController alloc] init];
	landingView = [[TMLandingView alloc] init];
	
	navController.navigationBar.tintColor = [UIColor colorWithHexString:@"173155"];
	
	[navController pushViewController:landingView animated:NO];
	[window addSubview:navController.view];

    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end

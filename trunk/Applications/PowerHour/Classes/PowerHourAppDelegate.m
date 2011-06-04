//
//  PowerHourAppDelegate.m
//  PowerHour
//
//  Created by Roth on 7/13/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "PowerHourAppDelegate.h"
#import "SelectSongViewController.h"
#import "ColorUtility.h"

@implementation PowerHourAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{   
	// Check the settings
	[self checkSettings];
	
    navController = [[UINavigationController alloc] init];
	[navController.navigationBar setTintColor:[ColorUtility colorWithHexString:@"333333"]];
	selectSongController = [[SelectSongViewController alloc] initWithStyle:UITableViewStyleGrouped];
	
	[navController pushViewController:selectSongController animated:NO];
	
	// Add the background image
	UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
	
	[window addSubview:imageView];
    [window addSubview:navController.view];
    [window makeKeyAndVisible];
}

- (void) checkSettings
{
	NSString *hasRunApp = [[NSUserDefaults standardUserDefaults] stringForKey:@"hasRunApp"];
	
	// Set the default values
	if(hasRunApp == nil)
	{
		[[NSUserDefaults standardUserDefaults] setValue:@"ofCourse" forKey:@"hasRunApp"];
		[[NSUserDefaults standardUserDefaults] setInteger:60 forKey:@"secondsPerSong"];
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shuffleSongs"];
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"randomStart"];
	}
}


- (void)dealloc {
    [navController release];
	[selectSongController release];
    [window release];
    [super dealloc];
}


@end

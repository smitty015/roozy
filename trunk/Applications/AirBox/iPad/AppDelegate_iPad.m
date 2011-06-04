//
//  AppDelegate_iPad.m
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "ABMiniWebServer.h"

@implementation AppDelegate_iPad

@synthesize window, rootViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the root view
	rootViewController = [[ABPadRootViewController alloc] init];
	rootViewController.view.frame = CGRectMake(0, 20, 768, 800);
	
	// Start the mini web server
	[[ABMiniWebServer sharedServer] start];
	
	// Display the window
	[self.window addSubview:rootViewController.view];
    [self.window makeKeyAndVisible];
	
	// Check if we're opening an external file
	NSURL *url = [launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
	if(url) [self application:[UIApplication sharedApplication] handleOpenURL:url];
    
    return YES;
}

- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	if(url && [url isFileURL] && rootViewController)
	{
		// When a file is opened, its copied to the docs directory, so refresh the standard file list
		[rootViewController refreshFileList];
	}
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc
{
	[rootViewController release];
    [window release];
    [super dealloc];
}


@end

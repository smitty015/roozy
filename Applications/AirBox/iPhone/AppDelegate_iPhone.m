//
//  AppDelegate_iPhone.m
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "ABMiniWebServer.h"

@implementation AppDelegate_iPhone

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{	
	// Create the root view
	rootViewController = [[ABPhoneRootViewController alloc] init];
	rootViewController.view.frame = CGRectMake(0, 20, 320, 460);
	
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


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
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

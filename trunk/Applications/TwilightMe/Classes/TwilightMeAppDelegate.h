//
//  TwilightMeAppDelegate.h
//  TwilightMe
//
//  Created by Roth on 11/25/09.
//  Copyright Roozy 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMLandingView.h"

@interface TwilightMeAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
	
	UINavigationController *navController;
	
	TMLandingView *landingView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end


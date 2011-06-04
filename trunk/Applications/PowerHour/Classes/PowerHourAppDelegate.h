//
//  PowerHourAppDelegate.h
//  PowerHour
//
//  Created by Roth on 7/13/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectSongViewController, NowPlayingViewController;

@interface PowerHourAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	
	UINavigationController *navController;
	SelectSongViewController *selectSongController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void) checkSettings;

@end


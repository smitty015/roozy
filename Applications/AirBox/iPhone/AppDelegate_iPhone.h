//
//  AppDelegate_iPhone.h
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABPhoneRootViewController.h"

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	ABPhoneRootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end


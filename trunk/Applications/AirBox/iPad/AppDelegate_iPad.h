//
//  AppDelegate_iPad.h
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABPadRootViewController.h"

@interface AppDelegate_iPad : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
	ABPadRootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) ABPadRootViewController *rootViewController;

@end


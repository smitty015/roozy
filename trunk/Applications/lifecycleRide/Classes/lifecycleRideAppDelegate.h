//
//  lifecycleRideAppDelegate.h
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class HomeViewController, StatusViewController;

@interface lifecycleRideAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UIWindow *window;
	
	// Main tab bar controller
	UITabBarController *tabBarController;
	
	// Nav controllers
	UINavigationController *homeNavController;
	UINavigationController *statusNavController;
	
	// View controllers
	HomeViewController *homeViewController;
	StatusViewController *statusViewController;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end


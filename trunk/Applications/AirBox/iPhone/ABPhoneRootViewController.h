//
//  ABPhoneRootViewController.h
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABFileTableViewController.h"
#import "AKAirplayManager.h"

@interface ABPhoneRootViewController : UIViewController <AKAirplayManagerDelegate, UIActionSheetDelegate, AKDeviceDelegate, ABFileTableViewControllerDelegate, UINavigationControllerDelegate>
{
	UINavigationController *rootNavController;
	ABFileTableViewController *fileTableViewController;
	
	IBOutlet UIView *mainContentView;
	IBOutlet UILabel *statusLabel;
	IBOutlet UIBarButtonItem *refreshButton;
	IBOutlet UIBarButtonItem *connectButton;
	IBOutlet UIImageView *ledImage;
	
	AKAirplayManager *airplay;
	NSMutableArray *foundDevices;
	
	NSTimer *previewTimer;
	UIViewController *currentPreviewController;
	
	//UIBarButtonItem *greenLEDItem;
	//UIBarButtonItem *redLEDItem;
}

- (BOOL) deviceExists:(AKDevice *)device;
- (IBAction) refreshFileList;
- (IBAction) showConnectOptions;
- (IBAction) openSettings;

- (void) chooseAirplayDeliveryForFile:(NSString *)fileName;

@end

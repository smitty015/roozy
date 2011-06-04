//
//  ARPadWebViewController.h
//  AirBox
//
//  Created by Andy Roth on 2/15/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "ABFileWebViewController.h"
#import "ABFileTableViewController.h"
#import "AKAirplayManager.h"


@interface ABPadWebViewController : UIViewController <UIPopoverControllerDelegate, ABFileTableViewControllerDelegate, UIActionSheetDelegate, AKAirplayManagerDelegate>
{
	IBOutlet UIToolbar *toolbar;
	ABFileWebViewController *webViewController;
	
	UIBarButtonItem *filesBarButton;
	IBOutlet UIBarButtonItem *actionButton;
	IBOutlet UIBarButtonItem *stopButton;
	IBOutlet UIBarButtonItem *settingsButton;
	IBOutlet UILabel *statusLabel;
	
	IBOutlet UIImageView *ledImage;
	
	UIPopoverController *popoverController;
	
	AKAirplayManager *airplay;
	NSMutableArray *foundDevices;
	
	NSTimer *previewTimer;
}

- (void) updateViewWithOrientation:(UIDeviceOrientation)orientation;

- (BOOL) deviceExists:(AKDevice *)device;
- (IBAction) tappedHelp;
- (IBAction) refreshAirplayDevices;
- (IBAction) showConnectOptions;
- (IBAction) stopSendingPreview;
- (IBAction) openSettings;

- (void) chooseAirplayDeliveryForFile:(NSString *)fileName;

- (void) sendPreview;

@end

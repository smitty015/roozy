    //
//  ARPadWebViewController.m
//  AirBox
//
//  Created by Andy Roth on 2/15/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABPadWebViewController.h"
#import "UIView+RIExtended.h"
#import "ABPhoneHelpViewController.h"
#import "ABMiniWebServer.h"
#import "RIToast.h"
#import "NSFileManager-Utilities.h"
#import "ABHost.h"
#import "AppDelegate_iPad.h"
#import "ABSettingsViewController.h"


@implementation ABPadWebViewController

#pragma mark -
#pragma mark Initialization

- (void) viewDidLoad
{
	webViewController = [[ABFileWebViewController alloc] init];
	webViewController.view.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44);
	[self.view addSubview:webViewController.view];
	
	filesBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Files" style:UIBarButtonItemStyleBordered target:self action:@selector(showFilesPopover)];
	
	// Setup the toolbar
	toolbar.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
	
	// Create the Airplay manager and look for devices
	foundDevices = [[NSMutableArray alloc] init];
	
	airplay = [[AKAirplayManager alloc] init];
	airplay.autoConnect = NO;
	airplay.delegate = self;
	[airplay findDevices];
	
	statusLabel.text = @"Finding Airplay devices";
}

#pragma mark -
#pragma mark Button Actions

- (void) showFilesPopover
{
	if(popoverController)
	{
		[popoverController dismissPopoverAnimated:YES];
		[popoverController release];
		popoverController = nil;
	}
	
	ABFileTableViewController *tableView = [[ABFileTableViewController alloc] initWithStyle:UITableViewStylePlain];
	[tableView addRefreshButton];
	tableView.contentSizeForViewInPopover = CGSizeMake(320, 480);
	tableView.delegate = self;
	
	UINavigationController *filesNavController = [[UINavigationController alloc] initWithRootViewController:tableView];
	tableView.navigationItem.titleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]] autorelease];
	
	popoverController = [[UIPopoverController alloc] initWithContentViewController:filesNavController];
	[popoverController presentPopoverFromBarButtonItem:filesBarButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
	[tableView release];
	[filesNavController release];
}

- (IBAction) tappedHelp
{
	ABPhoneHelpViewController *helpView = [[ABPhoneHelpViewController alloc] init];
	helpView.modalPresentationStyle = UIModalPresentationFormSheet;
	[((AppDelegate_iPad *)[UIApplication sharedApplication].delegate).rootViewController presentModalViewController:helpView animated:YES];
	
	[helpView release];
}

- (IBAction) openSettings
{
	if(popoverController)
	{
		[popoverController dismissPopoverAnimated:YES];
		[popoverController release];
		popoverController = nil;
	}
	
	ABSettingsViewController *settings = [[ABSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	settings.contentSizeForViewInPopover = CGSizeMake(320, 240);
	popoverController = [[UIPopoverController alloc] initWithContentViewController:settings];
	[popoverController presentPopoverFromBarButtonItem:settingsButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
	
	[settings release];
}

- (IBAction) showConnectOptions
{
	if(popoverController)
	{
		[popoverController dismissPopoverAnimated:YES];
		[popoverController release];
		popoverController = nil;
	}
	
	UIActionSheet *options = [[UIActionSheet alloc] initWithTitle:@"Connect to an Airplay device" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	
	AKDevice *device;
	for(device in foundDevices)
	{
		[options addButtonWithTitle:device.displayName];
	}
	
	if(airplay.connectedDevice) [options addButtonWithTitle:@"Disconnect"];
	[options addButtonWithTitle:@"Cancel"];
	
	if(airplay.connectedDevice) options.destructiveButtonIndex = options.numberOfButtons - 2;
	options.cancelButtonIndex = options.numberOfButtons - 1;
	
	[options showFromBarButtonItem:actionButton animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == actionSheet.destructiveButtonIndex)
	{
		// Disconnect
		[airplay.connectedDevice sendStop];
		airplay.connectedDevice = nil;
		ledImage.image = [UIImage imageNamed:@"led_red.png"];
		statusLabel.text = [NSString stringWithFormat:@"Found %d %@", [foundDevices count], [foundDevices count] == 1 ? @"device" : @"devices"];
	}
	else if(buttonIndex != actionSheet.cancelButtonIndex)
	{
		// Connect to the device
		AKDevice *device = [foundDevices objectAtIndex:buttonIndex];
		[airplay connectToDevice:device];
		statusLabel.text = @"Connecting";
	}
}

#pragma mark -
#pragma mark Airplay Delegate

- (IBAction) refreshAirplayDevices
{
	if(popoverController && [popoverController isKindOfClass:[ABFileTableViewController class]])
	{
		[(ABFileTableViewController *)popoverController.contentViewController refreshList];
	}
	
	[airplay findDevices];
}

- (BOOL) deviceExists:(AKDevice *)device
{
	AKDevice *temp;
	for(temp in foundDevices)
	{
		if([device.hostname isEqualToString:temp.hostname])
		{
			return YES;
		}
	}
	
	return NO;
}

- (void) manager:(AKAirplayManager *)manager didFindDevice:(AKDevice *)device
{
	if(![self deviceExists:device])
	{
		[foundDevices addObject:device];
		actionButton.enabled = YES;
		statusLabel.text = [NSString stringWithFormat:@"Found %d %@", [foundDevices count], [foundDevices count] == 1 ? @"device" : @"devices"];
	}
}

- (void) manager:(AKAirplayManager *)manager didConnectToDevice:(AKDevice *)device
{
	statusLabel.text = [NSString stringWithFormat:@"Connected to %@", device.displayName];
	ledImage.image = [UIImage imageNamed:@"led_green.png"];
	[RIToast showToast:@"Connected. Ready to send files." duration:RIToastDurationShort];
}

#pragma mark -
#pragma mark File List Delegate

- (void) fileWasSelected:(NSString *)fileName
{
	if(!airplay.connectedDevice)
	{
		[RIToast showToast:@"No devices are connected." duration:RIToastDurationShort];
	}
	else
	{
		[self chooseAirplayDeliveryForFile:fileName];
	}
}

#pragma mark -
#pragma mark Airplay Delivery

- (void) chooseAirplayDeliveryForFile:(NSString *)fileName
{
	NSArray *components = [fileName componentsSeparatedByString:@"."];
	NSString *extension = [components objectAtIndex:[components count]-1];
	
	stopButton.enabled = YES;
	
	// For images, just send the data
	if([extension isEqualToString:@"jpg"] ||
	   [extension isEqualToString:@"jpeg"] ||
	   [extension isEqualToString:@"png"] ||
	   [extension isEqualToString:@"gif"] ||
	   [extension isEqualToString:@"tiff"])
	{
		NSFileManager *manager = [NSFileManager defaultManager];
		NSString *fullPath = [NSString stringWithFormat:@"%@/%@", NSDocumentsFolder(), fileName];
		if([manager fileExistsAtPath:fullPath])
		{
			NSData *fileData = [[NSData alloc] initWithContentsOfFile:fullPath];
			
			int length = [fileData length];
			NSString *message = [[NSString alloc] initWithFormat:@"PUT /photo HTTP/1.1\n"
								 "Content-Length: %d\n"
								 "User-Agent: MediaControl/1.0\n\n", length];
			NSMutableData *messageData = [[NSMutableData alloc] initWithData:[message dataUsingEncoding:NSUTF8StringEncoding]];
			[messageData appendData:fileData];
			
			// Send the raw data
			[airplay.connectedDevice.socket writeData:messageData withTimeout:20 tag:1];
			
			[messageData release];
			[message release];
			[fileData release];
		}
	}
	// For video and audio, send the contentURL (video file is servered via the mini web server)
	else if([extension isEqualToString:@"mp4"] ||
			[extension isEqualToString:@"m4v"] ||
			[extension isEqualToString:@"mov"] ||
			[extension isEqualToString:@"mpeg"] ||
			[extension isEqualToString:@"mpg"] || 
			[extension isEqualToString:@"mp3"] || 
			[extension isEqualToString:@"aac"] ||
			[extension isEqualToString:@"m4a"])
	{
		NSString *ip = [ABHost firstIPAddress];
		NSString *fullURL = [[NSString alloc] initWithFormat:@"http://%@:%d/airbox/%@", ip, [ABMiniWebServer sharedServer].port, [fileName stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
		[airplay.connectedDevice sendContentURL:fullURL];
	}
	// For most other formats, display in a web view
	else if([extension isEqualToString:@"pdf"] ||
			[extension isEqualToString:@"rtf"] ||
			[extension isEqualToString:@"txt"] ||
			[extension isEqualToString:@"xlsx"] ||
			[extension isEqualToString:@"xls"] ||
			[extension isEqualToString:@"numbers"] ||
			[extension isEqualToString:@"doc"] ||
			[extension isEqualToString:@"docx"] ||
			[extension isEqualToString:@"pages"] ||
			[extension isEqualToString:@"ppt"] ||
			[extension isEqualToString:@"pptx"] ||
			[extension isEqualToString:@"key"])
	{
		webViewController.fileName = fileName;
		[webViewController refresh];
		
		if(previewTimer)
		{
			[previewTimer invalidate];
			[previewTimer release];
			previewTimer = nil;
		}
		
		previewTimer = [[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(sendPreview) userInfo:nil repeats:YES] retain];
	}
	else
	{
		stopButton.enabled = NO;
		[RIToast showToast:@"File format not supported." duration:RIToastDurationShort];
	}
}

#pragma mark -
#pragma mark Previewer

- (void) sendPreview
{
	UIImage *image = [webViewController.view viewAsImage];
	[airplay.connectedDevice sendImage:image];
}

- (IBAction) stopSendingPreview
{
	[previewTimer invalidate];
	previewTimer = nil;
	
	stopButton.enabled = NO;
	webViewController.fileName = nil;
	[webViewController refresh];
	
	[airplay.connectedDevice sendStop];
}

#pragma mark -
#pragma mark Orientation

- (void) updateViewWithOrientation:(UIDeviceOrientation)orientation
{
	if(UIInterfaceOrientationIsPortrait(orientation))
	{
		// Show the button
		NSMutableArray *items = [toolbar.items mutableCopy];
		[items insertObject:filesBarButton atIndex:0];
		toolbar.items = items;
		[items release];
	}
	else
	{
		// Hide the button
		NSMutableArray *items = [toolbar.items mutableCopy];
		[items removeObject:filesBarButton];
		toolbar.items = items;
		[items release];
	}
	
	if(popoverController)
	{
		[popoverController dismissPopoverAnimated:YES];
		[popoverController release];
		popoverController = nil;
	}
}

#pragma mark -
#pragma mark Cleanup

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[webViewController release];
	[filesBarButton release];
	[popoverController release];
	[airplay release];
	[foundDevices release];
	
    [super dealloc];
}


@end

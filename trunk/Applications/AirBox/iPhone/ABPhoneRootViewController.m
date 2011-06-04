//
//  ABPhoneRootViewController.m
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABPhoneRootViewController.h"
#import "ABHost.h"
#import "RIToast.h"
#import "ABMiniWebServer.h"
#import "ABPhoneHelpViewController.h"
#import "NSFileManager-Utilities.h"
#import "ABFileWebViewController.h"
#import "UIView+RIExtended.h"
#import "ABSettingsViewController.h"


@implementation ABPhoneRootViewController

#pragma mark -
#pragma mark Initialization

- (void) viewDidLoad
{
	// Create the main navigation and table view
	fileTableViewController = [[ABFileTableViewController alloc] initWithStyle:UITableViewStylePlain];
	fileTableViewController.delegate = self;
    rootNavController = [[UINavigationController alloc] initWithRootViewController:fileTableViewController];
	rootNavController.view.frame = CGRectMake(0, 0, mainContentView.frame.size.width, mainContentView.frame.size.height);
	rootNavController.delegate = self;
	rootNavController.navigationBar.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
	[mainContentView addSubview:rootNavController.view];
	
	// Setup the nav bar
	UIBarButtonItem *helpButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStyleBordered target:self action:@selector(tappedHelp)];
	fileTableViewController.navigationItem.titleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]] autorelease];
	fileTableViewController.navigationItem.leftBarButtonItem = helpButton;
	[helpButton release];
	
	// Create the Airplay manager and look for devices
	foundDevices = [[NSMutableArray alloc] init];
	
	airplay = [[AKAirplayManager alloc] init];
	airplay.autoConnect = NO;
	airplay.delegate = self;
	[airplay findDevices];
	
	statusLabel.text = @"Finding Airplay devices";
}

#pragma mark -
#pragma mark Toolbar Buttons

- (void) tappedHelp
{
	ABPhoneHelpViewController *helpView = [[ABPhoneHelpViewController alloc] init];
	[self presentModalViewController:helpView animated:YES];
	
	[helpView release];
}

- (IBAction) refreshFileList
{
	[fileTableViewController refreshList];
	[airplay findDevices];
}

- (IBAction) openSettings
{
	ABSettingsViewController *settings = [[ABSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	settings.navigationItem.title = @"Settings";
	
	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeSettings)];
	settings.navigationItem.leftBarButtonItem = closeButton;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settings];
	navController.navigationBar.tintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
	
	[self presentModalViewController:navController animated:YES];
	
	[closeButton release];
	[settings release];
	[navController release];
}

- (void) closeSettings
{
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) showConnectOptions
{
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
	
	[options showInView:self.view];
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
		
		if(rootNavController.topViewController != fileTableViewController)
		{
			[rootNavController popToViewController:fileTableViewController animated:YES];
		}
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
		connectButton.enabled = YES;
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
		ABFileWebViewController *pdfView = [[ABFileWebViewController alloc] init];
		pdfView.fileName = fileName;
		pdfView.navigationItem.title = fileName;
		[rootNavController pushViewController:pdfView animated:YES];
		currentPreviewController = pdfView;
		
		previewTimer = [[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(sendPreview) userInfo:nil repeats:YES] retain];
	}
	else
	{
		[RIToast showToast:@"File format not supported." duration:RIToastDurationShort];
	}
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if(viewController == fileTableViewController)
	{
		[currentPreviewController release];
		currentPreviewController = nil;
		
		[previewTimer invalidate];
		[previewTimer release];
		previewTimer = nil;
		
		[airplay.connectedDevice sendStop];
	}
}

#pragma mark -
#pragma mark Previewer

- (void) sendPreview
{
	if(currentPreviewController)
	{
		UIImage *image = [currentPreviewController.view viewAsImage];
		[airplay.connectedDevice sendImage:image];
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
	[fileTableViewController release];
	[rootNavController release];
	[foundDevices release];
	[airplay release];
	
    [super dealloc];
}


@end

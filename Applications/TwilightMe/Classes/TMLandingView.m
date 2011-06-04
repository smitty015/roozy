//
//  TMLandingView.m
//  TwilightMe
//
//  Created by Roth on 11/25/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "TMLandingView.h"
#import "TMEditView.h"
#import "TMPhotoTileListController.h"
#import "UIColor+ARExtended.h"
#import "TMSettingsView.h"
#import "TMBumpView.h"

static NSString *kBumpApiKey = @"5788d2ddd4bf429eb8bd12c5b387e3eb";

@implementation TMLandingView

- (void) viewDidLoad
{
	imagePicker = [[[UIImagePickerController alloc] init] retain];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
	imagePicker.navigationBar.tintColor = [UIColor colorWithHexString:@"173155"];
	imagePicker.view.backgroundColor = [UIColor blackColor];
	
	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(openSettings)];
	self.navigationItem.leftBarButtonItem = settingsButton;
	
	UIBarButtonItem *bumpButton = [[UIBarButtonItem alloc] initWithTitle:@"Bump" style:UIBarButtonItemStyleBordered target:self action:@selector(openBumpDialog)];
	self.navigationItem.rightBarButtonItem = bumpButton;
}

- (void) openSettings
{
	UINavigationController *settingsNavController = [[UINavigationController alloc] init];
	TMSettingsView *settingsView = [[TMSettingsView alloc] initWithStyle:UITableViewStyleGrouped];
	[settingsNavController pushViewController:settingsView animated:NO];
	
	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeSettings)];
	settingsView.navigationItem.leftBarButtonItem = closeButton;
	settingsView.navigationItem.title = @"Settings";
	
	settingsNavController.navigationBar.tintColor = [UIColor colorWithHexString:@"173155"];
	 
	[self presentModalViewController:settingsNavController animated:YES];
}

- (void) closeSettings
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark Photo Source Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select a photo source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
		actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
		[actionSheet showInView:self.view];
	}
	else
	{
		[self openLibrary];
	}

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
			[self openCamera];
			break;
		case 1:
			[self openLibrary];
			break;
		default:
			break;
	}
}

- (void) openCamera
{
	imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	
	[self presentModalViewController:imagePicker animated:YES];
}

- (void) openLibrary
{
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
	[self presentModalViewController:imagePicker animated:YES];
}

#pragma mark Image Picker Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissModalViewControllerAnimated:YES];
	
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	
	TMPhotoTileListController *tileList = [[TMPhotoTileListController alloc] init];
	[self.navigationController pushViewController:tileList animated:YES];
	tileList.listItems = [NSArray arrayWithObjects:
						  [UIImage imageNamed:@"twilightMe01.png"],
						  [UIImage imageNamed:@"twilightMe02.png"],
						  [UIImage imageNamed:@"twilightMe03.png"],
						  [UIImage imageNamed:@"twilightMe04.png"],
						  [UIImage imageNamed:@"twilightMe05.png"],
						  [UIImage imageNamed:@"twilightMe06.png"],
						  [UIImage imageNamed:@"twilightMe07.png"],
						  [UIImage imageNamed:@"twilightMe08.png"],
						  [UIImage imageNamed:@"twilightMe09.png"],
						  [UIImage imageNamed:@"twilightMe10.png"],
						  [UIImage imageNamed:@"twilightMe11.png"],
						  [UIImage imageNamed:@"twilightMe12.png"],
						  [UIImage imageNamed:@"twilightMe13.png"],
						  [UIImage imageNamed:@"twilightMe14.png"],
						  [UIImage imageNamed:@"twilightMe15.png"], 
						  [UIImage imageNamed:@"twilightMe16.png"], 
						  [UIImage imageNamed:@"twilightMe17.png"], 
						  [UIImage imageNamed:@"twilightMe18.png"], 
						  [UIImage imageNamed:@"twilightMe19.png"], 
						  [UIImage imageNamed:@"twilightMe20.png"], 
						  [UIImage imageNamed:@"twilightMe21.png"], nil];
	tileList.userImage = image;
}

#pragma mark Bump Methods

- (void) openBumpDialog
{
	bumpObject = [[Bump alloc] init];
	[bumpObject configAPIKey:kBumpApiKey];
	[bumpObject setDelegate:self];
	[bumpObject configActionMessage:@"Bump with someone to receive a photo."];
	[bumpObject connect];
}

- (void) bumpDidConnect
{
	TMBumpView *bumpView = [[TMBumpView alloc] init];
	bumpView.bumpObject = bumpObject;
	bumpView.bumpObject.delegate = bumpView;
	
	[self presentModalViewController:bumpView animated:YES];
	[bumpView sendNothing];
}

- (void) bumpDidDisconnect:(BumpDisconnectReason)reason
{
	
}

- (void) bumpConnectFailed:(BumpConnectFailedReason)reason
{
	
}

- (void) bumpDataReceived:(NSData *)chunk
{
	
}

#pragma mark Cleanup

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

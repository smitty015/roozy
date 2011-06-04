//
//  TMBumpView.m
//  TwilightMe
//
//  Created by Roth on 1/10/10.
//  Copyright 2010 Roozy. All rights reserved.
//

#import "TMBumpView.h"
#import "UIColor+ARExtended.h"


@implementation TMBumpView

@synthesize bumpObject;

- (void) viewDidLoad
{
	navBar.tintColor = [UIColor colorWithHexString:@"173155"];
	toolbar.tintColor = [UIColor colorWithHexString:@"173155"];
	
	roundedBox.cornerRadius = 10;
	roundedBox.rectColor = [UIColor blackColor];
	roundedBox.strokeWidth = 0;
}

#pragma mark Send/Receive

- (void) sendImage:(UIImage *)image
{
	NSData *data = UIImagePNGRepresentation(image);
	[bumpObject send:data];
}

- (void) sendNothing
{
	NSData *nullData = [[NSData alloc] init];
	[bumpObject send:nullData];
}

- (void) bumpDataReceived:(NSData *)chunk
{
	[activityView stopAnimating];
	roundedBox.hidden = YES;
	
	if([chunk length] > 0)
	{
		UIImage *image = [[UIImage alloc] initWithData:chunk];
		imageView.image = image;
		
		UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save Photo" style:UIBarButtonItemStyleBordered target:self action:@selector(saveToCameraRoll)];
		[[navBar.items objectAtIndex:0] setRightBarButtonItem:saveButton animated:YES];
	}
	else
	{
		noImageLabel.hidden = NO;
	}
}

#pragma mark Button Actions

- (IBAction) close
{
	[bumpObject disconnect];
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction) saveToCameraRoll
{
	UIImageWriteToSavedPhotosAlbum(imageView.image, self, nil, nil);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"The photo was saved to your Camera Roll." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark Bump Delegate

- (void) bumpDidConnect
{
	
}

- (void) bumpDidDisconnect:(BumpDisconnectReason)reason
{
	
}

- (void) bumpConnectFailed:(BumpConnectFailedReason)reason
{
	
}

#pragma mark Cleanup

- (void)didReceiveMemoryWarning
{
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

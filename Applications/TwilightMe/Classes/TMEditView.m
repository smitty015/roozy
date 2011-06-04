//
//  TMEditView.m
//  TwilightMe
//
//  Created by Roth on 11/25/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "TMEditView.h"
#import "TwilightMeAppDelegate.h"
#import "UIView+ARExtended.h"
#import "UIColor+ARExtended.h"
#import "FBConnect.h"
#import "NSString+ARExtended.h"
#import "Bump.h"
#import "TMBumpView.h"


@implementation TMEditView

static NSString *kFacebookApiKey = @"6da407c6f4a44d9d8709f49ea3712ba2";
static NSString *kFacebookApiSecret = @"2c22bea8d910310a83393af6b51af0a2";
static NSString *kBumpApiKey = @"5788d2ddd4bf429eb8bd12c5b387e3eb";

#pragma mark Initialization

- (void) viewDidLoad
{
	UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openMoreOptions)];
	self.navigationItem.rightBarButtonItem = moreButton;
	
	imagePicker = [[[UIImagePickerController alloc] init] retain];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
	
	adjustableImage.view.frame = CGRectMake(0, 0, 372, 372);
	
	rotationBackground.rectColor = [UIColor blackColor];
	rotationBackground.strokeColor = [UIColor blackColor];
	rotationBackground.alpha = 0.8;
	
	clickedMoreOptions = NO;
	
	toolbar.tintColor = [UIColor colorWithHexString:@"173155"];
	adjustableImage.view.backgroundColor = [UIColor blackColor];
	
	uploadingView.userInteractionEnabled = NO;
	uploadingView.hidden = YES;
}

- (void) setupWithUserImage:(UIImage *)image otherImage:(UIImage *)otherImage
{
	adjustableImage.image = image;
	topImage.image = otherImage;
	
	isGreyscale = NO;
}

#pragma mark Image Editing

- (IBAction) toggleAlpha
{
	if(topImage.alpha == 1.0)
	{
		topImage.alpha = 0.6;
		alphaButton.style = UIBarButtonItemStyleDone;
	}
	else
	{
		topImage.alpha = 1.0;
		alphaButton.style = UIBarButtonItemStyleBordered;
	}
}

- (IBAction) changeRotation
{
	adjustableImage.rotation = slider.value;
}

- (IBAction) flipHorizontal
{
	[adjustableImage flipHorizontal];
}

- (IBAction) toggleGreyscale
{
	isGreyscale = !isGreyscale;
	[adjustableImage toggleGreyScale];
	
	if(isGreyscale)
	{
		greyscaleButton.style = UIBarButtonItemStyleDone;
	}
	else
	{
		greyscaleButton.style = UIBarButtonItemStyleBordered;
	}
}

#pragma mark Other Options

- (void) openMoreOptions
{
	clickedMoreOptions = YES;
	
	if([MFMailComposeViewController canSendMail])
	{
		UIActionSheet *moreOptionsSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save to Camera Roll", @"Share on Facebook", @"Send with Bump", @"Email", nil];
		moreOptionsSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
		[moreOptionsSheet showInView:((TwilightMeAppDelegate *)[UIApplication sharedApplication].delegate).window];
	}
	else
	{
		UIActionSheet *moreOptionsSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save to Camera Roll", @"Share on Facebook", @"Send with Bump", nil];
		moreOptionsSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
		[moreOptionsSheet showInView:((TwilightMeAppDelegate *)[UIApplication sharedApplication].delegate).window];
	}

}

- (void) saveImage
{
	UIImage *viewImage = [renderView viewAsImage];
	
	UIImageWriteToSavedPhotosAlbum(viewImage, self, nil, nil);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"The photo was saved to your Camera Roll." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void) sendEmail
{
	if([MFMailComposeViewController canSendMail])
	{
		// Create the mail controller
		MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
		mailController.mailComposeDelegate = self;
		
		// Set the subject and body
		[mailController setSubject:@"Check out what I made with TwilightMe!"];
		[mailController setMessageBody:@"<a href='http://itunes.apple.com/us/app/twilightme'>Get TwilightMe from the App Store</a>." isHTML:YES];
		
		// Attach the image
		UIImage *viewImage = [renderView viewAsImage];
		
		NSData *imageData = UIImageJPEGRepresentation(viewImage, 1.0);
		[mailController addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"myTwilightPic.jpg"];
		
		[self presentModalViewController:mailController animated:YES];
		[mailController release];
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must have a mail account set up first.  Check your settings and try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) openCameraOptions
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
	if(clickedMoreOptions)
	{
		switch (buttonIndex)
		{
			case 0:
				[self saveImage];
				break;
			case 1:
				[self shareOnFacebook];
				break;
			case 2:
				[self openBumpDialog];
				break;
			case 3:
				[self sendEmail];
				break;
			default:
				break;
		}
	}
	else
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
	
	clickedMoreOptions = NO;
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

#pragma mark Facebook Share

- (void) shareOnFacebook
{
	facebookSession = [[FBSession sessionForApplication:kFacebookApiKey secret:kFacebookApiSecret delegate:self] retain];
	
	if(![facebookSession resume])
	{
		FBLoginDialog *loginView = [[FBLoginDialog alloc] initWithSession:facebookSession];
		[loginView show];
		[loginView release];
	}
}

- (void)session:(FBSession*)session didLogin:(FBUID)uid
{
	// Upload the image
	ARFileUploader *fileUploader = [[ARFileUploader alloc] initWithDelegate:self uploadServiceURI:@"http://www.roozy.net/twilight/upload.php"];
	[fileUploader uploadImage:[renderView viewAsImage]];
	
	// Show the progress view
	uploadingView.userInteractionEnabled = YES;
	uploadingView.hidden = NO;
}

- (void) fileUploader:(ARFileUploader *)uploader didSucceedWithResponse:(NSString *)response
{
	uploadingView.userInteractionEnabled = NO;
	uploadingView.hidden = YES;
	
	NSString *imageURL = [response removeWhitespace];
	imageURL = [NSString stringWithFormat:@"http://www.roozy.net/twilight/facebook/%@", imageURL];
	
	FBStreamDialog* dialog = [[[FBStreamDialog alloc] init] autorelease];
	dialog.delegate = self;
	dialog.userMessagePrompt = @"Share your TwilightMe photo on Facebook";
	dialog.attachment = [NSString stringWithFormat:@"{\"name\":\"TwilightMe\"," "\"href\":\"http://www.roozy.net\"," "\"caption\":\"Check out the photo I made with TwilightMe!\",\"description\":\"Get the TwilightMe iPhone app to turn yourself put yourself in a photo with other Twilight characters.\",\"media\":[{\"type\":\"image\",\"src\":\"%@\",\"href\":\"%@\"}]}", imageURL, imageURL];
	dialog.targetId = [NSString stringWithFormat:@"%d", [FBSession session].uid];
	[dialog show];
}

- (void) fileUploader:(ARFileUploader *)uploader didProgress:(CGFloat)progress
{
	
}

- (void) fileUploader:(ARFileUploader *)uploader didFail:(NSString *)response
{
	uploadingView.userInteractionEnabled = NO;
	uploadingView.hidden = YES;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error uploading your photo. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark Image Picker Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissModalViewControllerAnimated:YES];
	
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	adjustableImage.image = image;
	adjustableImage.rotation = 0;
	
	slider.value = 0;
}

#pragma mark Bump Methods

- (void) openBumpDialog
{
	bumpObject = [[Bump alloc] init];
	[bumpObject configAPIKey:kBumpApiKey];
	[bumpObject setDelegate:self];
	[bumpObject configActionMessage:@"Bump with someone to send your photo."];
	[bumpObject connect];
}

- (void) bumpDidConnect
{
	TMBumpView *bumpView = [[TMBumpView alloc] init];
	bumpView.bumpObject = bumpObject;
	bumpView.bumpObject.delegate = bumpView;
	
	[self presentModalViewController:bumpView animated:YES];
	[bumpView sendImage:[renderView viewAsImage]];
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

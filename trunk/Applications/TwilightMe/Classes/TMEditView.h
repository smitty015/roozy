//
//  TMEditView.h
//  TwilightMe
//
//  Created by Roth on 11/25/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ARAdjustableImageController.h"
#import "ARRoundedRectView.h"
#import "FBConnect.h"
#import "ARFileUploader.h"
#import "Bump.h"


@interface TMEditView : UIViewController <UIActionSheetDelegate,
											UIImagePickerControllerDelegate,
											UINavigationControllerDelegate,
											MFMailComposeViewControllerDelegate,
											FBSessionDelegate,
											ARFileUploaderDelgate,
											FBDialogDelegate,
											BumpDelegate>
{
	IBOutlet UIView *renderView;
	IBOutlet UIImageView *topImage;
	IBOutlet ARAdjustableImageController *adjustableImage;
	
	UIImage *originalImage;
	
	IBOutlet UIToolbar *toolbar;
	IBOutlet UISlider *slider;
	IBOutlet UIBarButtonItem *greyscaleButton;
	IBOutlet UIBarButtonItem *alphaButton;
	IBOutlet UIBarButtonItem *cameraButton;
	IBOutlet ARRoundedRectView *rotationBackground;
	
	UIImagePickerController *imagePicker;
	
	BOOL clickedMoreOptions;
	BOOL isGreyscale;
	
	FBSession *facebookSession;
	IBOutlet UIView *uploadingView;
	
	Bump *bumpObject;
}

- (void) setupWithUserImage:(UIImage *)image otherImage:(UIImage *)otherImage;
- (void) openCamera;
- (void) openLibrary;

- (void) saveImage;
- (void) sendEmail;
- (void) shareOnFacebook;
- (void) openBumpDialog;

- (IBAction) toggleAlpha;
- (IBAction) changeRotation;
- (IBAction) flipHorizontal;
- (IBAction) toggleGreyscale;
- (IBAction) openCameraOptions;

@end

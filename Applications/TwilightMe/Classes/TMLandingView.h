//
//  TMLandingView.h
//  TwilightMe
//
//  Created by Roth on 11/25/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bump.h"


@interface TMLandingView : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, BumpDelegate>
{
	UIImagePickerController *imagePicker;
	
	Bump *bumpObject;
}

- (void) openCamera;
- (void) openLibrary;

- (void) openBumpDialog;

@end

//
//  EditViewController.h
//  lifecycleRide
//
//  Created by Suzy Smith on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditViewControllerDelegate

- (void) editViewControllerDidSave;

@end


@interface EditViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	id <EditViewControllerDelegate> delegate;
	
	IBOutlet UIImageView	*currentImage;
	IBOutlet UITextField	*nameField;
	IBOutlet UITextField	*urlField;
	IBOutlet UIButton		*changePhotoButton;
	IBOutlet UIView *contentView;
	
	UIImagePickerController *imagePicker;
}

@property (nonatomic, assign) id <EditViewControllerDelegate> delegate;

-(IBAction) pickNewPhoto;
-(IBAction) save;
-(IBAction) cancel;

@end

//
//  EditViewController.m
//  lifecycleRide
//
//  Created by Suzy Smith on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "LRAppModel.h"
#import "LRUser.h"


@implementation EditViewController

@synthesize delegate;

#pragma mark -
#pragma mark Initialization

- (void) viewDidLoad
{
	LRUser *user = [LRAppModel sharedModel].user;
	
	// Pre-populate fields
	nameField.text = user.name;
	urlField.text = user.url;
	
	if(user.picture)
	{
		UIImage *pic = [[UIImage alloc] initWithData:user.picture];
		currentImage.image = pic;
		[pic release];
	}
	
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
}

#pragma mark -
#pragma mark Buttons Actions

-(IBAction) save
{
	LRUser *user = [LRAppModel sharedModel].user;
	
	user.name = nameField.text;
	user.url = urlField.text;
	user.picture = UIImageJPEGRepresentation(currentImage.image, 1.0);
	
	[[LRAppModel sharedModel].context save:NULL];
	
	[delegate editViewControllerDidSave];
	
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction) cancel
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

-(IBAction) pickNewPhoto
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Choose Existing", nil];
	[actionSheet showInView:self.view];
}

#pragma mark -
#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if(textField == nameField)
	{
		[urlField becomeFirstResponder];
	}
	else
	{
		[textField resignFirstResponder];
	}
	
	return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if(textField == urlField)
	{
		[UIView beginAnimations:@"moveView" context:nil];
		contentView.frame = CGRectMake(0, -30, 320, 416);
		[UIView commitAnimations];
	}
	else if(textField == nameField)
	{
		[UIView beginAnimations:@"moveView" context:nil];
		contentView.frame = CGRectMake(0, 22, 320, 416);
		[UIView commitAnimations];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[UIView beginAnimations:@"moveView" context:nil];
	contentView.frame = CGRectMake(0, 44, 320, 416);
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	switch (buttonIndex)
	{
		case 0:
			imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
			[self presentModalViewController:imagePicker animated:YES];
			break;
		case 1:
			imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentModalViewController:imagePicker animated:YES];
		default:
			break;
	}
}

#pragma mark -
#pragma mark Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissModalViewControllerAnimated:YES];
	
	UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
	currentImage.image = editedImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
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
	[imagePicker release];
	delegate = nil;
	
    [super dealloc];
}


@end

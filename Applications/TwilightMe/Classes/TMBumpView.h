//
//  TMBumpView.h
//  TwilightMe
//
//  Created by Roth on 1/10/10.
//  Copyright 2010 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bump.h"
#import "ARRoundedRectView.h"


@interface TMBumpView : UIViewController <BumpDelegate>
{
	Bump *bumpObject;
	
	IBOutlet UINavigationBar *navBar;
	IBOutlet UIToolbar *toolbar;
	IBOutlet UIImageView *imageView;
	IBOutlet UILabel *noImageLabel;
	IBOutlet UIActivityIndicatorView *activityView;
	IBOutlet ARRoundedRectView *roundedBox;
}

@property (nonatomic, retain) Bump *bumpObject;

- (void) sendImage:(UIImage *)image;
- (void) sendNothing;

- (IBAction) close;
- (IBAction) saveToCameraRoll;

@end

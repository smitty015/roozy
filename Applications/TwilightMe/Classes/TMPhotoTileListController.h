//
//  TMPhotoTileListController.h
//  TwilightMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTileListController.h"


@interface TMPhotoTileListController : ARTileListController
{
	NSArray *_listItems;
	UIImage *userImage;
}

@property (nonatomic, retain) NSArray *listItems;
@property (nonatomic, retain) UIImage *userImage;

@end

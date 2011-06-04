//
//  TMPhotoTileListCell.h
//  TwilightMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTileListCell.h"


@interface TMPhotoTileListCell : ARTileListCell
{
	UIImageView *backgroundImageView;
	UIImageView *cellImageView;
}

@property (nonatomic, retain) UIImage *image;

@end

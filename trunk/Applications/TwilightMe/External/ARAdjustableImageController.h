//
//  ARAdjustableImage.h
//  FameMe
//
//  Created by Roth on 11/27/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ARAdjustableImageController : UIViewController
{
	UIImageView *_imageView;
	UIImage *_originalImage;
	
	int _touchCount;
	UITouch *_savedTouch;
	
	// Moving properties
	CGPoint _centerPoint;
	CGRect _originalFrame;
	CGFloat _xOffset;
	CGFloat _yOffset;
	
	// Scaling properties
	CGFloat _originalDistance;
	CGFloat _scale;
	CGFloat _savedScale;
	
	// Rotating properties
	CGFloat _rotation;
	CGAffineTransform _savedTransform;
	
	// Color properties
	BOOL _isGreyScale;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat rotation;

- (void) flipHorizontal;
- (void) toggleGreyScale;

@end

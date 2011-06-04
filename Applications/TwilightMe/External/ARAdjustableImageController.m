//
//  ARAdjustableImage.m
//  FameMe
//
//  Created by Roth on 11/27/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "ARAdjustableImageController.h"
#import "UIView+ARExtended.h"
#import "UIImage+ARExtended.h"

@implementation ARAdjustableImageController

#pragma mark Getters/Setters

- (UIImage *) image
{
	return _imageView.image;
}

- (void) setImage:(UIImage *)image
{
	if(_imageView)
	{
		[_imageView removeFromSuperview];
		[_imageView release];
	}
	
	_originalImage = image;
	_isGreyScale = NO;
	_imageView = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:_imageView];
	
	self.view.transform = CGAffineTransformIdentity;
	
	_originalFrame = _imageView.frame;
	_centerPoint = CGPointMake(_originalFrame.origin.x + (_originalFrame.size.width / 2), _originalFrame.origin.y + (_originalFrame.size.height/2));
	_scale = 1;
	_savedScale = 1;
	_savedTransform = self.view.transform;
	_touchCount = 0;
}

- (CGPoint) centerPoint
{
	return _centerPoint;
}

- (void) setCenterPoint:(CGPoint)point
{
	CGFloat newX = point.x - (_imageView.width / 2);
	CGFloat newY = point.y - (_imageView.height / 2);
	
	if(newX + _imageView.width > 0 && newX < self.view.frame.size.width && newY + _imageView.height > 0 && newY < self.view.frame.size.height)
	{
		_centerPoint = point;
		
		_imageView.x = newX;
		_imageView.y = newY;
	}
}

- (CGFloat) scale
{
	return _scale;
}

- (void) setScale:(CGFloat)newScale
{
	if(newScale * _savedScale < 2.5 && newScale * _savedScale > 0.3)
	{
		_scale = newScale * _savedScale;
		
		_imageView.width = _originalFrame.size.width * _scale;
		_imageView.height = _originalFrame.size.height * _scale;
		
		self.centerPoint = _centerPoint;
	}
}

- (CGFloat) rotation
{
	return _rotation;
}

- (void) setRotation:(CGFloat)degrees
{
	_rotation = degrees;
	
	CGFloat radians = degrees * (M_PI / 180);
	self.view.transform = CGAffineTransformRotate(_savedTransform, radians);
}

- (void) flipHorizontal
{
	_imageView.transform = CGAffineTransformScale(_imageView.transform, -1.0, 1.0);
}

- (void) toggleGreyScale
{
	if(_isGreyScale)
	{
		_imageView.image = _originalImage;
		_isGreyScale = NO;
	}
	else
	{
		_imageView.image = [_imageView.image greyscaleCopy];
		_isGreyScale = YES;
	}
}

#pragma mark Touch Controls

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray *allTouches = [touches allObjects];
	_touchCount += [allTouches count];
	
	if(_touchCount == 1)
	{
		UITouch *touch = [allTouches objectAtIndex:0];
		CGPoint touchPoint = [touch locationInView:self.view];
		_xOffset = _centerPoint.x - touchPoint.x;
		_yOffset = _centerPoint.y - touchPoint.y;
		
		_savedTouch = touch;
	}
	else if(_touchCount == 2)
	{
		UITouch *touch1 = [allTouches objectAtIndex:0];
		CGPoint touchPoint1 = [touch1 locationInView:self.view];
		
		UITouch *touch2;
		if([allTouches count] == 2)
		{
			touch2 = [allTouches objectAtIndex:1];
		}
		else
		{
			touch2 = _savedTouch;
		}

		CGPoint touchPoint2 = [touch2 locationInView:self.view];
		
		CGFloat opp = abs(touchPoint1.y - touchPoint2.y);
		CGFloat adj = abs(touchPoint1.x - touchPoint2.x);
		_originalDistance = sqrt((opp * opp) + (adj * adj));
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray *allTouches = [touches allObjects];
	
	if(_touchCount == 1)
	{
		UITouch *touch = [allTouches objectAtIndex:0];
		CGPoint touchPoint = [touch locationInView:self.view];
		
		self.centerPoint = CGPointMake(touchPoint.x + _xOffset, touchPoint.y + _yOffset);
		
		_savedTouch = touch;
	}
	else if(_touchCount == 2 && [allTouches count] == 2)
	{
		UITouch *touch1 = [allTouches objectAtIndex:0];
		CGPoint touchPoint1 = [touch1 locationInView:self.view];
		
		UITouch *touch2;
		if([allTouches count] == 2)
		{
			touch2 = [allTouches objectAtIndex:1];
		}
		else
		{
			touch2 = _savedTouch;
		}
		
		CGPoint touchPoint2 = [touch2 locationInView:self.view];
		
		CGFloat opp = abs(touchPoint1.y - touchPoint2.y);
		CGFloat adj = abs(touchPoint1.x - touchPoint2.x);
		CGFloat newDistance = sqrt((opp * opp) + (adj * adj));
		self.scale = 1 + ((newDistance - _originalDistance) / 200);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	_savedScale = _scale;
	_touchCount = 0;
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"cancelled");
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

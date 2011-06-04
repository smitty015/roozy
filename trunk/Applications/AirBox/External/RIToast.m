//
//  RIToast.m
//  iLibraryCore
//
//  Created by Andy Roth on 11/19/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "RIToast.h"
#import "RIRoundedRectView.h"

#pragma mark -
#pragma mark Internal Toast View

@interface RIToastView : UIView
{
	RIRoundedRectView *backgroundView;
	UILabel *label;
	NSString *text;
}

@property (nonatomic, retain) NSString *text;

@end

@implementation RIToastView

- (id) initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		backgroundView = [[RIRoundedRectView alloc] initWithFrame:CGRectZero];
		backgroundView.strokeWidth = 0;
		backgroundView.cornerRadius = 5.0;
		backgroundView.rectColor = [UIColor blackColor];
		backgroundView.alpha = 0.8;
		[self addSubview:backgroundView];
		
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.opaque = NO;
		label.font = [UIFont systemFontOfSize:14.0];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		
		self.userInteractionEnabled = NO;
		self.autoresizesSubviews = NO;
		self.clipsToBounds = NO;
	}
	
	return self;
}

- (void) setText:(NSString *)value
{
	text = value;
	
	label.text = text;
	[label sizeToFit];
	
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	if (!window)
	{
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
	
	CGFloat maxWidth = window.frame.size.width - 40;
	if(label.frame.size.width > maxWidth)
	{
		label.numberOfLines = 2;
		label.frame = CGRectMake(0, 0, maxWidth, label.frame.size.height * 2);
	}
	
	backgroundView.frame = CGRectMake(-10, -10, label.frame.size.width+20, label.frame.size.height+20);
	[backgroundView setNeedsDisplay];
	
	self.frame = CGRectMake(0, 0, label.frame.size.width, label.frame.size.height);
}

- (NSString *) text
{
	return text;
}

- (void) dealloc
{
	[backgroundView release];
	[label release];
	[self.text release];
	
	[super dealloc];
}

@end

@interface RIToast (Private)

- (void) createNewToast:(NSString *)content length:(RIToastDuration)displayLength;
- (void) animateIn:(RIToastView *)toast duration:(RIToastDuration)duration;
- (void) animateOut:(RIToastView *)toast;
- (void) kill:(RIToastView *)toast;
- (void) reLayoutToast;

@end

@implementation RIToast

static RIToast *instance;
static RIToastView *currentToast;

#pragma mark -
#pragma mark Static Show Method

+ (void) showToast:(NSString *)content duration:(RIToastDuration)duration
{
	if(!instance)
	{
		instance = [[RIToast alloc] init];
		[[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(statusBarOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
	}
	
	[instance createNewToast:content length:duration];
}

#pragma mark -
#pragma mark Internal Methods

- (void) createNewToast:(NSString *)content length:(RIToastDuration)displayLength
{
	if(!currentToast)
	{
		RIToastView *newToast = [[RIToastView alloc] initWithFrame:CGRectZero];
		newToast.text = content;
		newToast.alpha = 0;
		
		currentToast = newToast;
		
		[self reLayoutToast];
		
		UIWindow* window = [UIApplication sharedApplication].keyWindow;
		if (!window)
		{
			window = [[UIApplication sharedApplication].windows objectAtIndex:0];
		}
		
		[window addSubview:newToast];
		
		[self animateIn:newToast duration:displayLength];
	}	
}

- (void) animateIn:(RIToastView *)toast duration:(RIToastDuration)duration
{
	[UIView beginAnimations:@"showToast" context:nil];
	toast.alpha = 1;
	[UIView commitAnimations];
	
	float durationSeconds = (duration == RIToastDurationLong ? 5 : 2);
	[self performSelector:@selector(animateOut:) withObject:toast afterDelay:durationSeconds];
}

- (void) animateOut:(RIToastView *)toast
{
	[UIView beginAnimations:@"hideToast" context:nil];
	toast.alpha = 0;
	[UIView commitAnimations];
	
	[self performSelector:@selector(kill:) withObject:toast afterDelay:0.3];
}

- (void) kill:(RIToastView *)toast
{
	currentToast = nil;
	[toast removeFromSuperview];
	[toast release];
}

- (void) statusBarOrientationChanged:(NSNotification *)note
{
	[self reLayoutToast];
}

- (void) reLayoutToast
{
	if(currentToast)
	{
		UIWindow* window = [UIApplication sharedApplication].keyWindow;
		if (!window)
		{
			window = [[UIApplication sharedApplication].windows objectAtIndex:0];
		}
		
		if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft)
		{
			int destY = round((window.frame.size.height/2) - (currentToast.frame.size.width/2));
			int destX = 70;
			
			currentToast.transform = CGAffineTransformMakeRotation(1.57079633);
			currentToast.frame = CGRectMake(destX, destY, currentToast.frame.size.width, currentToast.frame.size.height);
		}
		else if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
		{			
			int destY = round((window.frame.size.height/2) - (currentToast.frame.size.width/2));
			int destX = window.frame.size.width - 70 - currentToast.frame.size.height;
			
			currentToast.transform = CGAffineTransformMakeRotation(-1.57079633);
			currentToast.frame = CGRectMake(destX, destY, currentToast.frame.size.width, currentToast.frame.size.height);
		}
		else if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortraitUpsideDown)
		{
			currentToast.transform = CGAffineTransformMakeRotation(1.57079633 * 2);
			
			int destY = 130 - currentToast.frame.size.height;
			int destX = round((window.frame.size.width/2) - (currentToast.frame.size.width/2));
			
			currentToast.frame = CGRectMake(destX, destY, currentToast.frame.size.width, currentToast.frame.size.height);
		}
		else if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait)
		{
			currentToast.transform = CGAffineTransformIdentity;
			
			int destY = window.frame.size.height - 130;
			int destX = round((window.frame.size.width/2) - (currentToast.frame.size.width/2));
			
			currentToast.frame = CGRectMake(destX, destY, currentToast.frame.size.width, currentToast.frame.size.height);
		}
	}
}

@end
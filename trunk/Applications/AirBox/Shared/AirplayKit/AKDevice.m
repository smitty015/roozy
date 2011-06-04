//
//  AKDevice.m
//  AirplayKit
//
//  Created by Andy Roth on 1/18/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "AKDevice.h"
#import "ABAppModel.h"
#import "UIView+RIExtended.h"
#import "UIImage+Resize.h"


@implementation AKDevice

@synthesize hostname, port, delegate, connected, socket;

#pragma mark -
#pragma mark Initialization

- (id) init
{
	if((self = [super init]))
	{
		connected = NO;
		okToSend = YES;
	}
	
	return self;
}

- (NSString *) displayName
{
	NSString *name = hostname;
	if([hostname rangeOfString:@"-"].length != 0)
	{
		name = [hostname stringByReplacingCharactersInRange:[hostname rangeOfString:@"-"] withString:@" "];
	}
	
	if([name rangeOfString:@".local."].length != 0)
	{
		name = [name stringByReplacingCharactersInRange:[name rangeOfString:@".local."] withString:@""];
	}
	
	return name;
}

#pragma mark -
#pragma mark Public Methods

- (void) sendRawMessage:(NSString *)message
{
	self.socket.delegate = self;
	[self.socket writeData:[message dataUsingEncoding:NSUTF8StringEncoding] withTimeout:20 tag:1];
	[self.socket readDataWithTimeout:20.0 tag:1];
}

- (void) sendContentURL:(NSString *)url
{
	NSString *body = [[NSString alloc] initWithFormat:@"Content-Location: %@\r\n"
														"Start-Position: 0\r\n\r\n", url];
	int length = [body length];
	
	NSString *message = [[NSString alloc] initWithFormat:@"POST /play HTTP/1.1\r\n"
															 "Content-Length: %d\r\n"
															 "User-Agent: MediaControl/1.0\r\n\r\n%@", length, body];
	
	
	[self sendRawMessage:message];
	
	[body release];
	[message release];
}

- (void) sendImage:(UIImage *)image
{
	if(okToSend)
	{
		okToSend = NO;
		
		NSLog(@"sending image");
		
		NSData *imageData = nil;
		
		if([ABAppModel sharedModel].hdMode)
		{
			// Get HD Image
			imageData = UIImageJPEGRepresentation([self highResImageFromImage:image], [ABAppModel sharedModel].imageQuality);
		}
		else
		{
			imageData = UIImageJPEGRepresentation(image, [ABAppModel sharedModel].imageQuality);
		}
		
		int length = [imageData length];
		NSString *message = [[NSString alloc] initWithFormat:@"PUT /photo HTTP/1.1\r\n"
							 "Content-Length: %d\r\n"
							 "User-Agent: MediaControl/1.0\r\n\r\n", length];
		NSMutableData *messageData = [[NSMutableData alloc] initWithData:[message dataUsingEncoding:NSUTF8StringEncoding]];
		[messageData appendData:imageData];
		
		// Send the raw data
		self.socket.delegate = self;
		[self.socket writeData:messageData withTimeout:20 tag:1];
		[self.socket readDataWithTimeout:20.0 tag:1];
	}
}

- (void) sendStop
{
	NSString *message = @"POST /stop HTTP/1.1\r\n"
	"User-Agent: MediaControl/1.0\r\n\r\n";
	[self sendRawMessage:message];
}

- (void) sendReverse
{
	NSString *message = @"POST /reverse HTTP/1.1\r\n"
	"Upgrade: PTTH/1.0\r\n"
	"Connection: Upgrade\r\n"
	"X-Apple-Purpose: event\r\n"
	"Content-Length: 0\r\n"
	"User-Agent: MediaControl/1.0\r\n\r\n";
	
	[self sendRawMessage:message];
}

#pragma mark -
#pragma mark Image Methods

- (UIImage *) highResImageFromImage:(UIImage *)lowImage
{
	UIImageView *largeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1280, 720)];
	largeView.backgroundColor = [UIColor blackColor];
	largeView.contentMode = UIViewContentModeTop;
	largeView.image = [lowImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(1280, 1280) interpolationQuality:kCGInterpolationHigh];
	
	UIImage *highImage = [largeView viewAsImage];
	[largeView release];
	
	return highImage;
}

#pragma mark -
#pragma mark Socket Delegate

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"Recevied raw : %@", message);
	
	okToSend = YES;
}

#pragma mark -
#pragma mark Cleanup

- (void) dealloc
{
	[self sendStop];
	[socket release];
	[hostname release];
	[super dealloc];
}

@end
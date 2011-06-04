//
//  ARRemoteImage.m
//  CommonLibraries
//
//  Created by Roth on 11/4/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "ARRemoteImage.h"


@implementation ARRemoteImage

@synthesize delegate;

- (id) initWithSource:(NSString *)newSource withDelegate:(id <ARRemoteImageDelegate>)newDelegate
{
	if(self = [super init])
	{
		self.delegate = newDelegate;
		self.source = newSource;
	}
	
	return self;
}

- (void) setSource:(NSString *)newSource
{
	_source = newSource;
	
	if(delegate) [delegate remoteImageDidStartLoad:self];
	
	NSString *urlString = [_source stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	
	NSURL *realURL = [NSURL URLWithString:urlString];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:realURL];
	
	if(_connection && !_loadComplete)
	{
		[_connection cancel];
	}
	
	_connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( _connection )
	{
		_webData = [[NSMutableData data] retain];
		_loadComplete = NO;
	}
	else
	{
		if(delegate) [delegate remoteImageDidFail:self];
	}
}

- (NSString *)source
{
	return _source;
}

/*
 NSURLConnectionDelegate
 */
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	_totalSize = (NSUInteger)[response expectedContentLength];
	[_webData setLength: 0];
}


-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_webData appendData:data];
	
	CGFloat percent = (float)[_webData length] / (float)_totalSize;
	if(delegate) [delegate remoteImageDidProgress:self percent:percent];
}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connection release];
	[_webData release];
	
	if(delegate) [delegate remoteImageDidFail:self];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	UIImage *remoteImage = [[UIImage alloc] initWithData:_webData];
	self.image = remoteImage;
	
	if(delegate) [delegate remoteImageDidComplete:self];
	
	_loadComplete = YES;
	
	[connection release];
}


@end

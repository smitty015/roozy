//
//  ARJSONLoader.m
//  CommonLibraries
//
//  Created by Andrew Roth on 11/13/09.
//  Copyright 2009 Resource Interactive. All rights reserved.
//

#import "ARJSONLoader.h"
#import "JSON.h"


@implementation ARJSONLoader

- (id) initWithJSONDelegate:(id <ARJSONLoaderDelegate>) delegate
{
	if(self = [super init])
	{
		_delegate = delegate;
	}
	
	return self;
}

- (void) loadWithURL:(NSString *)url
{
	NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	
	NSURL *realURL = [NSURL URLWithString:urlString];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:realURL];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		_webData = [[NSMutableData data] retain];
	}
	else
	{
		[_delegate jsonLoader:self didFail:YES];
	}	
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
	if(_delegate) [_delegate jsonLoader:self didProgress:percent];
}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connection release];
	[_webData release];
	
	[_delegate jsonLoader:self didFail:YES];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	// Use XPath to return the results
	NSString *resultString = [[NSString alloc] initWithData:_webData encoding:NSASCIIStringEncoding];
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSObject *results = [parser objectWithString:resultString];
	
	[_delegate jsonLoader:self receivedResult:results];
	
	[connection release];
}

@end

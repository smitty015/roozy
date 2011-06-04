//
//  ARFoursquareLoginCall.m
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "ARFoursquareLoginCall.h"
#import "NSString+ARExtended.h"
#import "ARFoursquareManager.h"
#import "ARFoursquareUser.h"
#import "ARXMLLoader.h"
#import "XPathQuery.h"


@implementation ARFoursquareLoginCall

@synthesize delegate;

- (void) executeWithDelegate:(id <ARFoursquareLoginCallDelegate>)callDelegate
{
	self.delegate = callDelegate;
	
	ARFoursquareManager *manager = [ARFoursquareManager manager];
	NSString *encodedAuthString = [NSString base64EncodedStringWithString:[NSString stringWithFormat:@"%@:%@", manager.currentUser.email, manager.currentUser.password]];
	
	NSMutableURLRequest *loginRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.foursquare.com/v1/user"]];
	[loginRequest setHTTPMethod:@"GET"];
	[loginRequest setValue:[NSString stringWithFormat:@"Basic %@", encodedAuthString] forHTTPHeaderField:@"Authorization"];
	[loginRequest setValue:@"rothfoursquareapp:1.0" forHTTPHeaderField:@"User-Agent"];
	
	// Create the connection
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:loginRequest delegate:self];
	
	if( theConnection )
	{
		_webData = [[NSMutableData data] retain];
	}
	else
	{
		[self.delegate loginCallFailed];
	}
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[_webData setLength: 0];
}


-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_webData appendData:data];
}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connection release];
	[_webData release];
	
	[self.delegate loginCallFailed];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *response = [[NSString alloc] initWithData:_webData encoding:NSASCIIStringEncoding];
	
	if([response contains:@"unauthorized"])
	{
		[self.delegate loginCallFailed];
	}
	else
	{
		ARXMLLoader *tempLoader = [[ARXMLLoader alloc] initWithDelegate:nil];
		NSMutableArray *results = [tempLoader formatResults:PerformXMLXPathQuery(_webData, @"/user", @"", @"")];
		[self.delegate loginCallSucceededWithResponse:results];
	}
	
	[connection release];
}

@end

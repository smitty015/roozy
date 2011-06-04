//
//  ARFoursquareCheckinCall.m
//  CommonLibraries
//
//  Created by Andrew Roth on 3/16/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "ARFoursquareCheckinCall.h"
#import "ARFoursquareManager.h"
#import "NSString+ARExtended.h"
#import "ARXMLLoader.h"
#import "XPathQuery.h"


@implementation ARFoursquareCheckinCall

@synthesize delegate;

- (void) executeWithDelegate:(id <ARFoursquareCheckinCallDelegate>)callDelegate venueID:(NSString *)vid shoutMessage:(NSString *)message
{
	self.delegate = callDelegate;
	
	ARFoursquareManager *manager = [ARFoursquareManager manager];
	NSString *encodedAuthString = [NSString base64EncodedStringWithString:[NSString stringWithFormat:@"%@:%@", manager.currentUser.email, manager.currentUser.password]];
	
	NSMutableString *postString = [[NSMutableString alloc] init];
	if(vid) [postString appendString:[NSString stringWithFormat:@"vid=%@&", vid]];
	if(message) [postString appendString:[NSString stringWithFormat:@"shout=%@", message]];
	
	NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.foursquare.com/v1/checkin"]];
	
	[request setHTTPMethod:@"POST"];
	[request setValue:[NSString stringWithFormat:@"Basic %@", encodedAuthString] forHTTPHeaderField:@"Authorization"];
	[request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"rothfoursquareapp:1.0" forHTTPHeaderField:@"User-Agent"];
	[request setHTTPBody:postData];
	
	// Create the connection
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if( theConnection )
	{
		_webData = [[NSMutableData data] retain];
	}
	else
	{
		[self.delegate checkinCallFailed];
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
	
	[self.delegate checkinCallFailed];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *response = [[NSString alloc] initWithData:_webData encoding:NSASCIIStringEncoding];
	
	if([response contains:@"unauthorized"])
	{
		[self.delegate checkinCallFailed];
	}
	else
	{
		ARXMLLoader *tempLoader = [[ARXMLLoader alloc] initWithDelegate:nil];
		NSMutableArray *results = [tempLoader formatResults:PerformXMLXPathQuery(_webData, @"/checkin", @"", @"")];
		[self.delegate checkinCallSucceededWithResponse:results];
	}
	
	[connection release];
}

@end

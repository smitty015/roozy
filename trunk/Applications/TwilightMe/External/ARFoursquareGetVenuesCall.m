//
//  ARFoursquareGetVenuesCall.m
//  CommonLibraries
//
//  Created by Andrew Roth on 3/15/10.
//  Copyright 2010 Resource Interactive. All rights reserved.
//

#import "ARFoursquareGetVenuesCall.h"
#import "ARFoursquareManager.h"
#import "ARXMLLoader.h"
#import "XPathQuery.h"
#import "NSString+ARExtended.h"
#import <CoreLocation/CoreLocation.h>


@implementation ARFoursquareGetVenuesCall

@synthesize delegate;

- (void) executeWithDelegate:(id <ARFoursquareGetVenuesCallDelegate>)callDelegate
{
	self.delegate = callDelegate;
	
	CLLocationManager *manager = [[CLLocationManager alloc] init];
	manager.delegate = self;
	manager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	[manager startUpdatingLocation];
}

#pragma mark Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
	[manager stopUpdatingLocation];
	
	NSString *lat = [NSString stringWithFormat:@"%.4f", newLocation.coordinate.latitude];
	NSString *lon = [NSString stringWithFormat:@"%.4f", newLocation.coordinate.longitude];
	
	[self sendRequestWithLatitude:lat longitude:lon];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	[delegate getVenuesCallFailed];
}

#pragma mark Get Request

- (void) sendRequestWithLatitude:(NSString *)latitude longitude:(NSString *)longitude
{
	ARFoursquareManager *manager = [ARFoursquareManager manager];
	NSString *encodedAuthString = [NSString base64EncodedStringWithString:[NSString stringWithFormat:@"%@:%@", manager.currentUser.email, manager.currentUser.password]];
	
	NSString *getString = [NSString stringWithFormat:@"geolat=%@&geolong=%@", latitude, longitude];
	NSString *fullURL = [NSString stringWithFormat:@"http://api.foursquare.com/v1/venues?%@", getString];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:fullURL]];
	
	[request setHTTPMethod:@"GET"];
	[request setValue:[NSString stringWithFormat:@"Basic %@", encodedAuthString] forHTTPHeaderField:@"Authorization"];
	[request setValue:@"rothfoursquareapp:1.0" forHTTPHeaderField:@"User-Agent"];
	
	// Create the connection
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if( theConnection )
	{
		_webData = [[NSMutableData data] retain];
	}
	else
	{
		[self.delegate getVenuesCallFailed];
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
	
	[self.delegate getVenuesCallFailed];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *response = [[NSString alloc] initWithData:_webData encoding:NSASCIIStringEncoding];

	if([response contains:@"unauthorized"])
	{
		[self.delegate getVenuesCallFailed];
	}
	else
	{
		ARXMLLoader *tempLoader = [[ARXMLLoader alloc] initWithDelegate:nil];
		NSMutableArray *results = [tempLoader formatResults:PerformXMLXPathQuery(_webData, @"/venues", @"", @"")];
		[self.delegate getVenuesCallSucceededWithResponse:results];
	}
	
	[connection release];
}


@end

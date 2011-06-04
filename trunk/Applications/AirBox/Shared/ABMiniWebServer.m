//
//  ABMiniWebServer.m
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABMiniWebServer.h"
#import "NSString+RIExtended.h"
#import "NSFileManager-Utilities.h"


@implementation ABMiniWebServer

@synthesize port;

static ABMiniWebServer *instance;

#pragma mark -
#pragma mark Singleton

+ (ABMiniWebServer *) sharedServer
{
	if(!instance)
	{
		instance = [[ABMiniWebServer alloc] init];
	}
	
	return instance;
}

#pragma mark -
#pragma mark Public Methods

- (void) start
{
	if(!socket)
	{
		port = 9000;
		socket = [[AsyncSocket alloc] initWithDelegate:self];
		BOOL success = [socket acceptOnPort:port error:NULL];
		
		if(!success)
		{
			[socket release];
			socket = nil;
			NSLog(@"Error starting mini web server.");
		}
	}
}

- (void) stop
{
	if(socket)
	{
		[socket disconnect];
		[socket release];
		socket = nil;
	}
}

- (void) send404ToSocket:(AsyncSocket *)sock
{
	NSString *response = @"HTTP/1.1 404 Not Found\n"
						  "Content-Length: 0\n\n";
	
	[sock writeData:[response dataUsingEncoding:NSUTF8StringEncoding] withTimeout:20 tag:1];
}

#pragma mark -
#pragma mark Socket Delegate

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	
}

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
	
}

- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
	
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSString *message = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	
	// Parse the command that's been sent.
	NSArray *lines = [message componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	NSString *firstLine = [lines objectAtIndex:0];
	
	if([firstLine contains:@"GET /airbox/"])
	{
		firstLine = [firstLine replaceString:@"GET /airbox/" withString:@""];
		firstLine = [firstLine replaceString:@" HTTP/1.1" withString:@""];
		firstLine = [firstLine stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		
		NSFileManager *manager = [NSFileManager defaultManager];
		NSString *fullPath = [NSString stringWithFormat:@"%@/%@", NSDocumentsFolder(), firstLine];
		if([manager fileExistsAtPath:fullPath])
		{
			//NSLog(@"request in for %@", fullPath);
			
			NSData *fileData = [[NSData alloc] initWithContentsOfFile:fullPath];
			
			int length = [fileData length];
			NSString *response = [[NSString alloc] initWithFormat:@"HTTP/1.1 200 OK\n"
								 "Content-Length: %d\n\n", length];
			NSMutableData *responseData = [[NSMutableData alloc] initWithData:[response dataUsingEncoding:NSUTF8StringEncoding]];
			[responseData appendData:fileData];
			
			// Send the raw data
			[sock writeData:responseData withTimeout:20 tag:1];
			
			[responseData release];
			[response release];
			[fileData release];
		}
		else
		{
			[self send404ToSocket:sock];
		}
	}
	else
	{
		[self send404ToSocket:sock];
	}
	
	[message release];
}

- (BOOL)onSocketWillConnect:(AsyncSocket *)sock
{
	[sock readDataWithTimeout:30.0 tag:0];
	return YES;
}

@end

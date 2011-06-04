//
//  ARMP3Player.m
//  CommonLibraries
//
//  Created by Andrew Roth on 8/26/09.
//  Copyright 2009 Resource Interactive. All rights reserved.
//

#import "ARMP3Player.h"
#import "AudioStreamer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>


@implementation ARMP3Player

@synthesize delegate;

- (id) initWithStreamURL:(NSString *)streamURL
{
	if(self = [super init])
	{
		_streamURL = streamURL;
	}
	
	return self;
}

- (double) progress
{
	return streamer.progress;
}

#pragma mark Public Methods
- (void) play
{
	[self createStreamer];
	[streamer start];
}

- (void) stop
{
	[streamer stop];
}

- (void) pause
{
	[streamer pause];
}

#pragma mark Internal Methods

- (void)createStreamer
{
	if (streamer)
	{
		return;
	}
	
	[self destroyStreamer];
	
	NSString *escapedValue =
	[(NSString *)CFURLCreateStringByAddingPercentEscapes(
														 nil,
														 (CFStringRef)_streamURL,
														 NULL,
														 NULL,
														 kCFStringEncodingUTF8)
	 autorelease];
	
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(playbackStateChanged:)
	 name:ASStatusChangedNotification
	 object:streamer];
}

- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
		 removeObserver:self
		 name:ASStatusChangedNotification
		 object:streamer];
		
		[streamer stop];
		[streamer release];
		streamer = nil;
	}
}

- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting])
	{
		// Loading
		[delegate playerDidWait:self];
	}
	else if ([streamer isPlaying])
	{
		// Playing
		[delegate playerDidPlay:self];
	}
	else if ([streamer isIdle])
	{
		// Stopped
		[delegate playerDidStop:self];
	}
	else if([streamer isPaused])
	{
		// Pause
		[delegate playerDidPause:self];
	}
}

@end

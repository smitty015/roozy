//
//  ARMP3Player.h
//  CommonLibraries
//
//  Created by Andrew Roth on 8/26/09.
//  Copyright 2009 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 ARMP3PlayerDelegate - responds to streaming events
*/
@class ARMP3Player;

@protocol ARMP3PlayerDelegate

@optional

- (void) playerDidWait:(ARMP3Player *)mp3Player;
- (void) playerDidPlay:(ARMP3Player *)mp3Player;
- (void) playerDidPause:(ARMP3Player *)mp3Player;
- (void) playerDidStop:(ARMP3Player *)mp3Player;

@end

@class AudioStreamer;

@interface ARMP3Player : NSObject
{
	NSString *_streamURL;
	AudioStreamer *streamer;
	id <ARMP3PlayerDelegate> delegate;
}

@property (nonatomic, retain) id <ARMP3PlayerDelegate> delegate;
@property (readonly) double progress;

- (id) initWithStreamURL:(NSString *)streamURL;

- (void) createStreamer;
- (void) destroyStreamer;

- (void) play;
- (void) stop;
- (void) pause;

@end

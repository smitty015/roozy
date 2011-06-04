//
//  PowerHourViewController.m
//  PowerHour
//
//  Created by Roth on 7/13/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "NowPlayingViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation NowPlayingViewController

- (void)viewDidLoad
{	
    [super viewDidLoad];
	
	// Add the nav bar elements
	artistLabel = [self createNewLabel:CGRectMake(60, 3, 200, 14)];
	albumLabel = [self createNewLabel:CGRectMake(60, 15, 200, 14)];
	songLabel = [self createNewLabel:CGRectMake(60, 27, 200, 14)];
	
	[self.navigationController.navigationBar addSubview:artistLabel];
	[self.navigationController.navigationBar addSubview:albumLabel];
	[self.navigationController.navigationBar addSubview:songLabel];
	
	blankImage = [UIImage imageNamed:@"DefaultAlbum.png"];
}
				   
- (UILabel *) createNewLabel:(CGRect)withFrame
{
	UILabel *theLabel = [[UILabel alloc] initWithFrame:withFrame];
	theLabel.backgroundColor = [UIColor clearColor];
	theLabel.textColor = [UIColor whiteColor];
	theLabel.opaque = NO;
	theLabel.font = [UIFont boldSystemFontOfSize:11];
	theLabel.textAlignment = UITextAlignmentCenter;
	
	return theLabel;
}

- (void) viewWillDisappear:(BOOL)animated
{
	artistLabel.hidden = YES;
	albumLabel.hidden = YES;
	songLabel.hidden = YES;
	
	[timer invalidate];
	[mediaPlayer stop];
}

- (void) viewWillAppear:(BOOL)animated
{	
	artistLabel.hidden = NO;
	albumLabel.hidden = NO;
	songLabel.hidden = NO;
	
	// Set the volume control
	[volumeSlider setValue:mediaPlayer.volume];
}

- (void) setSongs:(MPMediaItemCollection *)songs
{
	secondsPerSong = [[NSUserDefaults standardUserDefaults] integerForKey:@"secondsPerSong"];
	shuffleSongs = [[NSUserDefaults standardUserDefaults] boolForKey:@"shuffleSongs"];
	randomStart = [[NSUserDefaults standardUserDefaults] boolForKey:@"randomStart"];
	
	// Create the music player
	mediaPlayer = [MPMusicPlayerController applicationMusicPlayer];
	[mediaPlayer setQueueWithItemCollection:songs];
	
	if(shuffleSongs)
	{
		mediaPlayer.shuffleMode = MPMusicShuffleModeSongs;	
	}
	else
	{
		mediaPlayer.shuffleMode = MPMusicShuffleModeOff;
	}
	
	// Set the volume control
	[volumeSlider setValue:mediaPlayer.volume];
}

- (void) startGame
{
	paused = YES;
	minutesPassed = 0;
	seconds = secondsPerSong;
	
	timerLabel.text = [NSString stringWithFormat:@"%d", seconds];
	
	// Disable the back button
	previousButton.enabled = NO;
	
	// Play the songs
	[self togglePlayPause];
	
	// Start the timer
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
	
	// Set the labels about the current song
	[self updateSongInfo];
}

- (void) handleTimer:(NSTimer *)theTimer
{
	if(!paused)
	{
		seconds = seconds - 1;
		if(seconds == 0)
		{
			// Reset the seconds and go to the next song
			seconds = secondsPerSong;
			previousButton.enabled = YES;
			[mediaPlayer skipToNextItem];
			
			// Update the minutes passed
			minutesPassed = minutesPassed + 1;
			minutesPassedLabel.text = [NSString stringWithFormat:@"%d minutes passed", minutesPassed];
			
			// Set the labels about the current song
			[self updateSongInfo];
		}
		
		timerLabel.text = [NSString stringWithFormat:@"%d", seconds];
	}
}

- (IBAction) gotoPrevious;
{
	[mediaPlayer skipToPreviousItem];
	[self updateSongInfo];
}

- (IBAction) gotoNext
{
	previousButton.enabled = YES;
	[mediaPlayer skipToNextItem];
	[self updateSongInfo];
}

- (IBAction) togglePlayPause
{
	if(paused)
	{
		paused = NO;
		[mediaPlayer play];
		playPauseButton.image = [UIImage imageNamed:@"pause.png"];
	}
	else
	{
		paused = YES;
		[mediaPlayer pause];
		playPauseButton.image = [UIImage imageNamed:@"play.png"];
	}
}

- (IBAction) sliderChanged
{
	NSLog([NSString stringWithFormat:@"volume : %f, slider: %f", mediaPlayer.volume, volumeSlider.value]);
	[mediaPlayer setVolume:volumeSlider.value]; 
}

- (void) updateSongInfo
{
	if(randomStart)
	{
		NSNumber *totalTime = [mediaPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration];
		u_int32_t availableTime = (u_int32_t)((int)totalTime/10000 - 60);
		double randomStartTime = arc4random() % availableTime;

		mediaPlayer.currentPlaybackTime = randomStartTime;
	}
	
	// Set the labels about the current song
	artistLabel.text = [mediaPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
	albumLabel.text = [mediaPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyAlbumTitle];
	songLabel.text = [mediaPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
	
	MPMediaItemArtwork *artwork = [mediaPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyArtwork];
	
	if(artwork != nil)
	{
		albumArtworkView.image = [artwork imageWithSize:albumArtworkView.bounds.size];
	}
	else
	{
		albumArtworkView.image = blankImage;
	}
	
	[self checkForEnd];	
}

- (void) checkForEnd
{
	if(mediaPlayer.nowPlayingItem == nil)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[mediaPlayer release];
	[timer release];
	[artistLabel release];
	[albumLabel release];
	[songLabel release];
	[blankImage release];
	[bottomToolbar release];
	[timerLabel release];
	[previousButton release];
	[playPauseButton release];
	[nextButton release];
	[minutesPassedLabel release];
	[albumArtworkView release];
	[volumeSlider release];
	
    [super dealloc];
}

@end

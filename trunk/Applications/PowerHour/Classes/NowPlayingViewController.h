//
//  PowerHourViewController.h
//  PowerHour
//
//  Created by Roth on 7/13/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NowPlayingViewController : UIViewController
{
	MPMusicPlayerController *mediaPlayer;
	
	BOOL paused;
	int minutesPassed;
	int seconds;
	
	int secondsPerSong;
	BOOL shuffleSongs;
	BOOL randomStart;
	
	NSTimer *timer;
	
	UILabel *artistLabel;
	UILabel *albumLabel;
	UILabel *songLabel;
	UIImage *blankImage;
	
	IBOutlet UIToolbar *bottomToolbar;
	IBOutlet UILabel *timerLabel;
	IBOutlet UIBarButtonItem *previousButton;
	IBOutlet UIBarButtonItem *playPauseButton;
	IBOutlet UIBarButtonItem *nextButton;
	IBOutlet UILabel *minutesPassedLabel;
	IBOutlet UIImageView *albumArtworkView;
	IBOutlet UISlider *volumeSlider;
}

- (UILabel *) createNewLabel:(CGRect)withFrame;
- (void) setSongs:(MPMediaItemCollection *)songs;

- (void) startGame;
- (void) handleTimer:(NSTimer *)theTimer;

- (IBAction) gotoPrevious;
- (IBAction) gotoNext;
- (IBAction) togglePlayPause;
- (IBAction) sliderChanged;

- (void) updateSongInfo;
- (void) checkForEnd;

@end


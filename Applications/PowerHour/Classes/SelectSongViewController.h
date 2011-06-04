//
//  SelectSongViewController.h
//  PowerHour
//
//  Created by Roth on 7/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class NowPlayingViewController;

@interface SelectSongViewController : UITableViewController <MPMediaPickerControllerDelegate>
{
	MPMediaItemCollection *songCollection;
	
	NowPlayingViewController *nowPlayingController;
	MPMediaPickerController *mediaPicker;
	
	BOOL settingsAreOpen;
}

@end

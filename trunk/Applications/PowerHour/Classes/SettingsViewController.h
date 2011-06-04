//
//  SettingsViewController.h
//  PowerHour
//
//  Created by Roth on 7/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UITableViewController
{
	int secondsPerSong;
	BOOL shuffleSongs;
	BOOL randomStart;
	
	UILabel *secondsLabel;
	UISlider *secondsSlider;
	UISwitch *shuffleSwitch;
	UISwitch *randomStartSwitch;
}

@end

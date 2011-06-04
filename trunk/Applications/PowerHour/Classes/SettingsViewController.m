//
//  SettingsViewController.m
//  PowerHour
//
//  Created by Roth on 7/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
	[self.navigationItem setLeftBarButtonItem:closeButton];
	
	self.title = @"Settings";
}

- (void) close
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
	secondsPerSong = [[NSUserDefaults standardUserDefaults] integerForKey:@"secondsPerSong"];
	shuffleSongs = [[NSUserDefaults standardUserDefaults] boolForKey:@"shuffleSongs"];
	randomStart = [[NSUserDefaults standardUserDefaults] boolForKey:@"randomStart"];
	
	[self.tableView reloadData];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[[NSUserDefaults standardUserDefaults] setInteger:secondsPerSong forKey:@"secondsPerSong"];
	[[NSUserDefaults standardUserDefaults] setBool:shuffleSongs forKey:@"shuffleSongs"];
	[[NSUserDefaults standardUserDefaults] setBool:randomStart forKey:@"randomStart"];
}

- (void) secondsChanged
{
	secondsPerSong = (int) secondsSlider.value;
	secondsLabel.text = [NSString stringWithFormat:@"Seconds per song                    %d", secondsPerSong];
}

- (void) shuffleToggled
{
	shuffleSongs = shuffleSwitch.on;
}

- (void) randomStartToggled
{
	randomStart = randomStartSwitch.on;
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == 0)
	{
		return @"Media Player";
	}
	
	return @"Defaults";
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
	{
		return 4;
	}
	
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if(indexPath.section == 0 && indexPath.row == 0)
	{
		cell.textLabel.text = [NSString stringWithFormat:@"Seconds per song                    %d", secondsPerSong];
		
		if(secondsLabel == nil)
		{
			secondsLabel = cell.textLabel;
		}
	}
	else if(indexPath.section == 0 && indexPath.row == 1)
	{
		if(secondsSlider == nil)
		{
			secondsSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, 10, 230, 10)];
			[secondsSlider setMinimumValue:30.0];
			[secondsSlider setMaximumValue:120.0];
			[secondsSlider setValue:secondsPerSong];
			[secondsSlider addTarget:self action:@selector(secondsChanged) forControlEvents:UIControlEventValueChanged];
		}
		[cell addSubview:secondsSlider];
	}
	else if(indexPath.section == 0 && indexPath.row == 2)
	{
		cell.textLabel.text = @"Shuffle";
		
		// Add the switch
		if(shuffleSwitch == nil)
		{
			shuffleSwitch = [[UISwitch alloc] init];
			[shuffleSwitch setFrame:CGRectMake(200, 9, shuffleSwitch.frame.size.width, shuffleSwitch.frame.size.height)];
			[shuffleSwitch setOn:shuffleSongs];
			[shuffleSwitch addTarget:self action:@selector(shuffleToggled) forControlEvents:UIControlEventValueChanged];
		}
		
		[cell addSubview:shuffleSwitch];
	}
	else if(indexPath.section == 0 && indexPath.row == 3)
	{
		cell.textLabel.text = @"Random Start";
		
		// Add the switch
		if(randomStartSwitch == nil)
		{
			randomStartSwitch = [[UISwitch alloc] init];
			[randomStartSwitch setFrame:CGRectMake(200, 9, randomStartSwitch.frame.size.width, randomStartSwitch.frame.size.height)];
			[randomStartSwitch setOn:randomStart];
			[randomStartSwitch addTarget:self action:@selector(randomStartToggled) forControlEvents:UIControlEventValueChanged];
		}
		
		[cell addSubview:randomStartSwitch];
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if(indexPath.section == 1)
	{
		cell.textLabel.text = @"Reset all settings";
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section == 1)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Reset all settings to default values?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		[alert show];
		[alert release];
		
		[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{
		secondsPerSong = 60;
		shuffleSongs = YES;
		randomStart = NO;
		
		secondsLabel.text = [NSString stringWithFormat:@"Seconds per song                    %d", secondsPerSong];
		secondsSlider.value = 60.0;
		shuffleSwitch.on = YES;
		randomStartSwitch.on = NO;
	}
}

- (void)dealloc {
    [super dealloc];
}


@end


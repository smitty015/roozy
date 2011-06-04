//
//  SelectSongViewController.m
//  PowerHour
//
//  Created by Roth on 7/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SelectSongViewController.h"
#import "NowPlayingViewController.h"
#import "SettingsViewController.h"
#import "ColorUtility.h"


@implementation SelectSongViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	settingsAreOpen = NO;

	// Set the background
    self.tableView.backgroundColor = [UIColor clearColor];
	
	// Add the header
	UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
	UIImageView *headerView = [[UIImageView alloc] initWithImage:logoImage];
	
	// Add the footer
	UIView *footerView = [[UIView alloc] init];
	[footerView setFrame:CGRectMake(0, 0, 320, 100)];
	
	UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	footerLabel.font = [UIFont boldSystemFontOfSize:16];
	footerLabel.textColor = [UIColor whiteColor];
	footerLabel.backgroundColor = [UIColor clearColor];
	footerLabel.opaque = NO;
	footerLabel.text = @"Made by Roozy";
	footerLabel.textAlignment = UITextAlignmentCenter;
	
	UIImageView *footerLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"duckLogo.png"]];
	footerLogo.frame = CGRectMake((320 - footerLogo.frame.size.width)/2, 50, footerLogo.frame.size.width, footerLogo.frame.size.height);
	
	[footerView addSubview:footerLabel];
	[footerView addSubview:footerLogo];
	[self.tableView setTableHeaderView:headerView];
	[self.tableView setTableFooterView:footerView];
	
	// Create the now playing controller
	nowPlayingController = [[NowPlayingViewController alloc] initWithNibName:@"NowPlayingViewController" bundle:[NSBundle mainBundle]];
	
	// Add nav bar elements
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Quit" style:UIBarButtonItemStylePlain target:self action:nil];
	[self.navigationItem setBackBarButtonItem:backButton];
	
	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(openSettings)];
	[self.navigationItem setLeftBarButtonItem:settingsButton];
}

- (void) viewWillAppear:(BOOL)animated
{
	if(settingsAreOpen == NO)
	{
		songCollection = nil;
		[self.tableView reloadData];
	}
	
	settingsAreOpen = NO;
}

- (void)mediaPicker:(MPMediaPickerController *)theMediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
	[self dismissModalViewControllerAnimated:YES];
	[mediaPicker release];
	
	if(mediaItemCollection.count > 0)
	{
		[nowPlayingController setSongs:mediaItemCollection];
		songCollection = mediaItemCollection;
		[self.tableView reloadData];
	}
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)theMediaPicker
{
	[self dismissModalViewControllerAnimated:YES];
	[mediaPicker release];
}

- (void) openSettings
{
	settingsAreOpen = YES;
	
	// Create the nav controller
	UINavigationController *navController = [[UINavigationController alloc] init];
	[navController.navigationBar setTintColor:[ColorUtility colorWithHexString:@"333333"]];
	
	SettingsViewController *settingsController = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[navController pushViewController:settingsController animated:NO];
	[self presentModalViewController:navController animated:YES];
	
	[navController release];
	[settingsController release];
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


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
	{
		return 2;
	}
	else if(section == 1)
	{
		return 1;
	}
	
	return 0;
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
		cell.textLabel.text = @"Choose songs";
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	else if(indexPath.section == 0 && indexPath.row == 1)
	{
		cell.textLabel.text = [NSString stringWithFormat:@"%d songs selected", songCollection.count];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	else if(indexPath.section == 1)
	{
		cell.textLabel.text = @"Start Hour of Power";
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		
		if(songCollection != nil && songCollection.count > 0)
		{
			cell.textLabel.alpha = 1;
			cell.userInteractionEnabled = YES;
		}
		else
		{
			cell.textLabel.alpha = 0.5;
			cell.userInteractionEnabled = NO;
		}
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
	{
		// Create the picker controller
		mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
		mediaPicker.delegate = self;
		mediaPicker.allowsPickingMultipleItems = YES;
		[self presentModalViewController:mediaPicker animated:YES];
	}
	else if(indexPath.section == 1)
	{		
		// Show the now playing controller
		[self.navigationController pushViewController:nowPlayingController animated:YES];
		[nowPlayingController startGame];
	}
}


- (void)dealloc
{
	[songCollection release];
	[nowPlayingController release];
	[mediaPicker release];
    [super dealloc];
}


@end


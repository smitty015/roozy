//
//  ABSettingsViewController.m
//  AirBox
//
//  Created by Andy Roth on 2/16/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABSettingsViewController.h"
#import "ABAppModel.h"


@implementation ABSettingsViewController


#pragma mark -
#pragma mark Initialization

- (void) viewDidLoad
{
	self.tableView.allowsSelection = NO;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == 0)
	{
		return @"Display";
	}
	
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	if(section == 0)
	{
		return @"Using HD resolution or increasing the image quality may decrease network performance.";
	}
	
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Display section
    if(section == 0)
	{
		return 3;
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
    
	// HD Output
	if(indexPath.section == 0 && indexPath.row == 0)
	{
		cell.textLabel.text = @"HD Resolution";
		cell.textLabel.font = [UIFont systemFontOfSize:14.0];
		
		UISwitch *hdSwitch = [[UISwitch alloc] init];
		hdSwitch.on = [ABAppModel sharedModel].hdMode;
		hdSwitch.center = CGPointMake(250, cell.center.y);
		[hdSwitch addTarget:self action:@selector(tappedHDSwitch:) forControlEvents:UIControlEventValueChanged];
		[cell addSubview:hdSwitch];
		[hdSwitch release];
	}
	// Image Quality Label
	else if(indexPath.section == 0 && indexPath.row == 1)
	{
		cell.textLabel.text = @"Image Quality";
		cell.textLabel.font = [UIFont systemFontOfSize:14.0];
	}
	// Image Quality Switch
	else if(indexPath.section == 0 && indexPath.row == 2)
	{
		UISlider *slider = [[UISlider alloc] init];
		slider.value = [ABAppModel sharedModel].imageQuality;
		slider.frame = CGRectMake(0, 0, 250, slider.frame.size.height);
		slider.center = cell.center;
		slider.minimumValue = 0.10;
		slider.maximumValue = 1.0;
		[slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
		[cell addSubview:slider];
		[slider release];
	}
    
    return cell;
}

#pragma mark -
#pragma mark Actions

- (void) tappedHDSwitch:(id)sender
{
	UISwitch *hdSwitch = (UISwitch *)sender;
	[ABAppModel sharedModel].hdMode = hdSwitch.on;
}

- (void) sliderChanged:(id)sender
{
	UISlider *slider = (UISlider *)sender;
	[ABAppModel sharedModel].imageQuality = slider.value;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end


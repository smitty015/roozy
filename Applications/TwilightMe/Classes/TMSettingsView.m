//
//  TMSettingsView.m
//  TwilightMe
//
//  Created by Roth on 12/6/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "TMSettingsView.h"
#import "FBConnect.h"
#import "UIColor+ARExtended.h"


@implementation TMSettingsView

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section == 0)
	{
		return @"Facebook";
	}
	
	return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
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
    
    cell.textLabel.text = @"Logout of Facebook";
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[FBSession session] logout];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You have been logged out of Facebook." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)dealloc {
    [super dealloc];
}


@end


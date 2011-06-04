//
//  ABFileTableViewController.m
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABFileTableViewController.h"
#import "ABAppModel.h"
#import "ABFileTableViewCell.h"
#import "NSFileManager-Utilities.h"


@implementation ABFileTableViewController

@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad
{
	files = [[[ABAppModel sharedModel] files] retain];
	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) refreshList
{
	[files release];
	files = [[[ABAppModel sharedModel] files] retain];
	[self.tableView reloadData];
}

- (void) addRefreshButton
{
	UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshList)];
	self.navigationItem.leftBarButtonItem = refresh;
	[refresh release];
}

#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [files count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ABFileTableViewCell *cell = (ABFileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[ABFileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	NSString *file = (NSString *)[files objectAtIndex:indexPath.row];
	[cell setFilename:file];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		NSFileManager *manager = [NSFileManager defaultManager];
		NSString *fullPath = [NSString stringWithFormat:@"%@/%@", NSDocumentsFolder(), [files objectAtIndex:indexPath.row]];
		[manager removeItemAtPath:fullPath error:NULL];
		
		[files release];
		files = [[[ABAppModel sharedModel] files] retain];
		
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }   
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(delegate && [delegate respondsToSelector:@selector(fileWasSelected:)])
	{
		[delegate fileWasSelected:[files objectAtIndex:indexPath.row]];
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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


- (void)dealloc
{
	[files release];
    [super dealloc];
}


@end


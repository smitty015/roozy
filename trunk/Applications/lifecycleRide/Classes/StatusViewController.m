//
//  StatusViewController.m
//  lifecycleRide
//
//  Created by Suzy Smith on 1/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatusViewController.h"
#import "InputDataViewController.h"
#import "StatusWeekViewController.h"
#import "LRConstants.h"

@implementation StatusViewController

@synthesize weeks;

#pragma mark -
#pragma mark Init

- (void) viewDidLoad
{
	/*UIBarButtonItem *input = [[UIBarButtonItem alloc] initWithTitle:@"Input" style:UIBarButtonItemStyleBordered target:self action:@selector(tappedInput)];
	
	self.navigationItem.title = @"ALC 2011";
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.rightBarButtonItem = input;
	[input release];
	[self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];*/
	self.navigationController.navigationBarHidden = YES;
	
	weeks = [[NSArray arrayWithObjects:@"Week 1 (1.3-9)", @"Week 2 (1.10-16)", @"Week 3 (1.17-23)", @"Week 4 (1.24-30)", @"Week 5 (1.31-2.6)", @"Week 6 (2.7-13)", @"Week 7 (2.14-20)", @"Week 8 (2.21-27)", @"Week 9 (2.28-3.6)", @"Week 10 (3.7-13)",
			  @"Week 11 (3.14-20)", @"Week 12 (3.21-27)", @"Week 13 (3.28-4.3)", @"Week 14 (4.4-10)", @"Week 15 (4.11-17)", @"Week 16 (4.18-24)", @"Week 17 (4.25-5.1)", @"Week 18 (5.2-8)", @"Week 19 (5.9-15)", @"Week 20 (5.16-22)",
			  @"Week 21 (5.23-29)", nil] retain];
	
	self.tableView.frame = CGRectMake(0, 91, 320, 320);
	
	//UIImageView *header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusViewHeader.png"]];
	//[self.view addSubview:header];
}

- (void) viewWillAppear:(BOOL)animated
{
	[self refreshData];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void) refreshData
{
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Input Data delegate

- (void) inputDataViewControllerDidSave
{
	[self refreshData];
}

#pragma mark -
#pragma mark Button Actions

- (void) tappedInput
{
	InputDataViewController *inputDataViewController = [[InputDataViewController alloc] init];
	inputDataViewController.delegate = self;
	[self presentModalViewController:inputDataViewController animated:YES];
	
	[inputDataViewController release];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 118;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"statusViewHeader.png"]];
	UIButton *inputButton = [[UIButton alloc] initWithFrame:CGRectMake(253, 6, 60, 30)];
	[inputButton setImage:[UIImage imageNamed:@"inputButton.png"] forState:UIControlStateNormal];
	[inputButton addTarget:self action:@selector(tappedInput) forControlEvents:UIControlEventTouchUpInside];
	[imageView addSubview:inputButton];
	[inputButton release];
	imageView.userInteractionEnabled = YES;
	
	return [imageView autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [weeks count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// weeks - highlight current
	// weeks - week # with x miles needed/x miles goal
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSString *name = (NSString *)[weeks objectAtIndex:indexPath.row];
	
	// Get goals miles
	int goal = [LRConstants getGoalMiles:(indexPath.row+1)];
	int miles = [LRConstants getMilesForWeek:(indexPath.row + 1)];
	
	cell.textLabel.text = name;
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18.0];
	cell.textLabel.textColor = [UIColor darkGrayColor];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%d/%d", miles, goal];
	cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	StatusWeekViewController *weekDetails = [[StatusWeekViewController alloc] init];
	weekDetails.week = indexPath.row+1;
	[self.navigationController pushViewController:weekDetails animated:YES];
	
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Cleanup

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

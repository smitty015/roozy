//
//  TMPhotoTileListController.m
//  TwilightMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "TMPhotoTileListController.h"
#import "TMEditView.h"
#import "TMPhotoTileListCell.h"


@implementation TMPhotoTileListController

@synthesize userImage;

- (void) viewDidLoad
{
	self.navigationItem.title = @"Select a photo";
	self.view.frame = CGRectMake(0, 0, 320, 416);
	
	self.view.backgroundColor = [UIColor clearColor];
	
	UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TileListBackground.png"]];
	[self.view insertSubview:backgroundView atIndex:0];
}

- (void) setListItems:(NSArray *)items
{
	_listItems = items;
	
	[self reloadData];
}

- (NSArray *) listItems
{
	return _listItems;
}

#pragma mark Overrides

- (int) numberOfTotalCells
{
	return [_listItems count];
}

- (ARTileListCell *)cellForIndex:(int)index
{
	TMPhotoTileListCell *cell = [[TMPhotoTileListCell alloc] init];
	cell.image = (UIImage *)[_listItems objectAtIndex:index];
	
	return cell;
}

- (void) didSelectCell:(ARTileListCell *)cell
{
	TMEditView *editView = [[TMEditView alloc] init];
	[self.navigationController pushViewController:editView animated:YES];
	[editView setupWithUserImage:userImage otherImage:((TMPhotoTileListCell *)cell).image];
}

@end

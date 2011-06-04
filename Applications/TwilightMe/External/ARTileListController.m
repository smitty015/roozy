//
//  ARTileListController.m
//  FameMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "ARTileListController.h"
#import "ARTileListCell.h"


@implementation ARTileListController

@synthesize scrollView;

#define DEFAULT_TILE_WIDTH 106
#define DEFAULT_TILE_HEIGHT 124
#define DEFAULT_NUM_ROWS 3
#define DEFAULT_NUM_COLS 3

- (id) init
{
	if(self = [super init])
	{
		scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
		scrollView.delaysContentTouches = NO;
		
		_direction = ARTileListDirectionVertical;
		
		[self.view addSubview:scrollView];
		
		[self reloadData];
	}
	
	return self;
}

#pragma mark Getters/Setters

- (ARTileListDirection) direction
{
	return _direction;
}

- (void) setDirection:(ARTileListDirection)newDirection
{
	_direction = newDirection;
	[self reloadData];
}

#pragma mark Data Methods

- (void) reloadData
{
	// Tiles each item by numRows or numColumns, numColumns when list is vertical or numRows when list is horizontal
	int columnCount = 0;
	int rowCount = 0;
	for(int i = 0; i < [self numberOfTotalCells]; i++)
	{
		tempX = columnCount * [self tileWidth];
		tempY = rowCount * [self tileHeight];
		
		ARTileListCell *cell = [self cellForIndex:i];
		cell.frame = CGRectMake(tempX, tempY, [self tileWidth], [self tileHeight]);
		cell.delegate = self;
		
		if(_direction == ARTileListDirectionVertical)
		{
			columnCount++;
			if(columnCount == [self numCols])
			{
				columnCount = 0;
				rowCount++;
			}
		}
		else if(_direction == ARTileListDirectionHorizontal)
		{
			rowCount++;
			if(rowCount == [self numRows])
			{
				rowCount = 0;
				columnCount++;
			}
		}
		
		[scrollView addSubview:cell];
	}
	
	if(_direction == ARTileListDirectionVertical)
	{
		scrollView.contentSize = CGSizeMake([self numCols] * [self tileWidth], ceilf((float)[self numberOfTotalCells] / (float)[self numCols]) * [self tileHeight]);
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.showsVerticalScrollIndicator = YES;
	}
	else if(_direction == ARTileListDirectionHorizontal)
	{
		scrollView.contentSize = CGSizeMake(ceilf((float)[self numberOfTotalCells] / (float)[self numRows]) * [self tileWidth], [self numRows] * [self tileHeight]);
		scrollView.showsHorizontalScrollIndicator = YES;
		scrollView.showsVerticalScrollIndicator = NO;
	}
}

- (void) clearData
{
	for(int i = 0; i < [scrollView.subviews count]; i++)
	{
		UIView *child = (UIView *)[scrollView.subviews objectAtIndex:i];
		[child removeFromSuperview];
		[child release];
	}
}

#pragma mark Cell Setup

- (int) numberOfTotalCells
{
	return 0;
}

- (CGFloat) tileHeight
{
	return DEFAULT_TILE_HEIGHT;
}

- (CGFloat) tileWidth
{
	return DEFAULT_TILE_WIDTH;
}

- (int) numRows
{
	return DEFAULT_NUM_ROWS;
}

- (int) numCols
{
	return DEFAULT_NUM_COLS;
}

- (ARTileListCell *)cellForIndex:(int)index
{
	ARTileListCell *cell = [[ARTileListCell alloc] initWithFrame:CGRectMake(tempX, tempY, [self tileWidth], [self tileHeight])];
	
	return cell;
}

#pragma mark Actions

- (void) didSelectCell:(ARTileListCell *)cell
{
	
}

#pragma mark Cleanup

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

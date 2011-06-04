//
//  ARTileListController.h
//  FameMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARTileListCell.h"

typedef enum ARTileListDirection
{
	ARTileListDirectionHorizontal,
	ARTileListDirectionVertical
} ARTileListDirection;

@interface ARTileListController : UIViewController <ARTileListCellDelegate>
{
	UIScrollView *scrollView;
	ARTileListDirection _direction;
	
@private
	CGFloat tempX;
	CGFloat tempY;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic) ARTileListDirection direction;

// Reloads the data or clears the data without recreating the tiles
- (void) reloadData;
- (void) clearData;

// Override for click action
- (void) didSelectCell:(ARTileListCell *)cell;

// Override for list setup
- (int) numberOfTotalCells;
- (CGFloat) tileHeight;
- (CGFloat) tileWidth;
- (int) numRows;
- (int) numCols;
- (ARTileListCell *)cellForIndex:(int)index;

@end

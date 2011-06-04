//
//  ARTileListCell.h
//  FameMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARTileListCell;

@protocol ARTileListCellDelegate

- (void) didSelectCell:(ARTileListCell *)cell;

@end


@interface ARTileListCell : UIView
{
	id <ARTileListCellDelegate> delegate;
}

@property (nonatomic, retain) id <ARTileListCellDelegate> delegate;

// State styles, override for custom highlighted and selected states
- (void) setHighlighted;
- (void) setUnhighlighted;
- (void) setSelected;

@end

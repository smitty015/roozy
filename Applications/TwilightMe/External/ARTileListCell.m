//
//  ARTileListCell.m
//  FameMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "ARTileListCell.h"


@implementation ARTileListCell

@synthesize delegate;

#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
		// BG : 107 x 124
		// Image : 87 x 101
    }
    return self;
}

#pragma mark Selection Logic

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self setHighlighted];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self setSelected];
	[delegate didSelectCell:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self setUnhighlighted];
}

#pragma mark Overridden methods
- (void) setHighlighted
{
	
}

- (void) setUnhighlighted
{
	
}

- (void) setSelected
{
	
}

#pragma mark Cleanup

- (void)dealloc {
    [super dealloc];
}


@end

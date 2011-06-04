//
//  TMPhotoTileListCell.m
//  TwilightMe
//
//  Created by Roth on 11/30/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "TMPhotoTileListCell.h"


@implementation TMPhotoTileListCell


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
		backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TileBG.png"]];
		[self addSubview:backgroundImageView];
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark Getters/Setters

- (void) setImage:(UIImage *)newImage
{
	cellImageView = [[UIImageView alloc] initWithImage:newImage];
	cellImageView.frame = CGRectMake(10, 10, 87, 101);
	
	UIView *blackView = [[UIView alloc] initWithFrame:cellImageView.frame];
	blackView.backgroundColor = [UIColor blackColor];
	
	[self addSubview:blackView];
	[self addSubview:cellImageView];
}

- (UIImage *)image
{
	return cellImageView.image;
}

#pragma mark Styles

- (void) setHighlighted
{
	backgroundImageView.image = [UIImage imageNamed:@"TileBG_Highlighted.png"];
}

- (void) setUnhighlighted
{
	backgroundImageView.image = [UIImage imageNamed:@"TileBG.png"];
}

- (void) setSelected
{
	backgroundImageView.image = [UIImage imageNamed:@"TileBG.png"];
}

#pragma mark Cleanup

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}


@end

//
//  ARToggleButtonGroup.m
//  CommonLibraries
//
//  Created by Roth on 8/2/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "ARToggleButtonGroup.h"
#import "ARToggleButton.h"


@implementation ARToggleButtonGroup

- (id) init
{
	if(self = [super init])
	{
		_buttons = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (id) initWithButtons:(NSArray *)buttons
{
	if(self = [self init])
	{
		for(int i = 0; i < [buttons count]; i++)
		{
			[self addButton:(ARToggleButton *)[buttons objectAtIndex:i]];
		}
	}
	
	return self;
}

- (ARToggleButton *) selectedButton
{
	ARToggleButton *tempButton;
	
	for(int i = 0; i < [_buttons count]; i++)
	{
		tempButton = (ARToggleButton *)[_buttons objectAtIndex:i];
		
		if(tempButton.on)
		{
			return tempButton;
		}
	}
	
	return nil;
}

- (void) addButton:(ARToggleButton *)newButton
{
	newButton.group = self;
	[_buttons addObject:newButton];
}

- (void) didClickButton:(ARToggleButton *)button
{
	NSLog(@"checking");
	ARToggleButton *tempButton;
	
	for(int i = 0; i < [_buttons count]; i++)
	{
		tempButton = (ARToggleButton *)[_buttons objectAtIndex:i];
		
		if(button != tempButton)
		{
			tempButton.on = NO;
		}
	}
}

@end

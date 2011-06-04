#import "ARToggleButton.h"
#import "ARToggleButtonGroup.h"


@implementation ARToggleButton

@synthesize enableClick, group;

- (id) init
{
	if(self = [super init])
	{
		_on = NO;
	}
	
	return self;
}

- (id) initWithImages:(UIImage *)onImage offImage:(UIImage *)offImage
{
	if(self = [self init])
	{
		[self setImages:onImage offImage:offImage];
	}
	
	return self;
}

- (void) setOn:(BOOL)isOn
{
	_on = isOn;
	
	if(_on)
	{
		[self setImage:_onImage forState:UIControlStateNormal];
		[self setImage:_onImage forState:UIControlStateHighlighted];
	}
	else
	{
		[self setImage:_offImage forState:UIControlStateNormal];
		[self setImage:_offImage forState:UIControlStateHighlighted];
	}
	
	[self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL) on
{
	return _on;
}

- (void) setImages:(UIImage *)onImage offImage:(UIImage *)offImage
{
	[self setTitle:nil forState:UIControlStateNormal];
	
	// Set the images
	_onImage = onImage;
	_offImage = offImage;
	
	// Refresh
	[self setOn:NO];
}

- (void) onClick
{
	[self setOn:!_on];
	if(group) [group didClickButton:self];
}

@end

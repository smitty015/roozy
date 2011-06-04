//
//  ARToggleButtonGroup.h
//  CommonLibraries
//
//  Created by Roth on 8/2/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARToggleButton;

@interface ARToggleButtonGroup : NSObject
{
@private
	NSMutableArray *_buttons;
}

@property (nonatomic, readonly) ARToggleButton *selectedButton;

- (id) initWithButtons:(NSArray *)buttons;
- (void) addButton:(ARToggleButton *)newButton;
- (void) didClickButton:(ARToggleButton *)button;

@end

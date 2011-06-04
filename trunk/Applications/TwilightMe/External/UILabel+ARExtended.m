//
//  UILabel+ARExtended.m
//  CommonLibraries
//
//  Created by Roth on 9/16/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "UILabel+ARExtended.h"
#import "UIColor+ARExtended.h"


@implementation UILabel (ARExtended)

+ (UILabel *) labelWithText:(NSString *)labelText ofSize:(CGFloat)labelSize withColorHex:(NSString *)labelColor
{
	UILabel *tempLabel = [[UILabel alloc] init];
	tempLabel.backgroundColor = [UIColor clearColor];

	tempLabel.font = [UIFont systemFontOfSize:labelSize];
	
	tempLabel.text = labelText;
	tempLabel.textColor = [UIColor colorWithHexString:labelColor];
	
	[tempLabel sizeToFit];

	return [tempLabel autorelease];
}

@end

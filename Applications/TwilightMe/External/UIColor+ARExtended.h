//
//  ARExtendedColor.h
//  CommonLibraries
//
//  Created by Andrew Roth on 8/19/09.
//  Copyright 2009 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (ARExtended)

// Color space utility methods
- (CGColorSpaceModel) colorSpaceModel;

// RGB components
- (BOOL) canProvideRGBComponents;
- (CGFloat) red;
- (CGFloat) green;
- (CGFloat) blue;
- (CGFloat) alpha;
- (CGFloat) luminance;

// String utility methods
- (NSString *) hexString;

// Static methods
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end

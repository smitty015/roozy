//
//  UIImage+ARExtended.h
//  CommonLibraries
//
//  Created by Roth on 12/1/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (ARExtended)

// Returns a greyscale copy of the image
- (UIImage *) greyscaleCopy;

// Returns a copy of the image using edge detection
- (UIImage *) edgeDetectionCopy;

@end

//
//  UIImage+ARExtended.m
//  CommonLibraries
//
//  Created by Roth on 12/1/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import "UIImage+ARExtended.h"
#import "ARImage.h"

@implementation UIImage (ARExtended)

- (UIImage *) greyscaleCopy
{
	ARImageWrapper *greyScale = ARImage::createImage(self, self.size.width, self.size.height);
	return greyScale.image->toUIImage();
}

- (UIImage *) edgeDetectionCopy
{
	ARImageWrapper *greyScale = ARImage::createImage(self, self.size.width, self.size.height);
	ARImageWrapper *edges = greyScale.image->gaussianBlur().image->cannyEdgeExtract(0.3,0.7);
	return edges.image->toUIImage();
}

@end

/**
 * iLibraryCore
 *
 * Created by Andy Roth.
 * Copyright 2009 Resource Interactive. All rights reserved.
 */

#import <Foundation/Foundation.h>


@interface UIView (RIExtended)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (UIImage *) viewAsImage;

@end

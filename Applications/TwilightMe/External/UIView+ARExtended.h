//
//  UIView+ARExtended.h
//  CommonLibraries
//
//  Created by Andrew Roth on 11/5/09.
//  Copyright 2009 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (ARExtended)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (UIImage *) viewAsImage;

@end

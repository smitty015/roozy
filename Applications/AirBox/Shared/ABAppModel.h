//
//  ABAppModel.h
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ABAppModel : NSObject
{

}

+ (ABAppModel *) sharedModel;

@property (nonatomic) BOOL hdMode;
@property (nonatomic) float imageQuality;

- (NSArray *) files;

@end

//
//  ABAppModel.m
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABAppModel.h"
#import "NSFileManager-Utilities.h"


@implementation ABAppModel

static ABAppModel *instance;

#pragma mark -
#pragma mark Singleton

+ (ABAppModel *) sharedModel
{
	if(!instance)
	{
		instance = [[ABAppModel alloc] init];
		
		BOOL hasWrittenDefaults = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasWrittenDefaults"];
		if(!hasWrittenDefaults)
		{
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasWrittenDefaults"];
			
			instance.hdMode = NO;
			instance.imageQuality = 0.75;
		}
	}
	
	return instance;
}

#pragma mark -
#pragma mark Public Methods

- (BOOL) hdMode
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:@"hdMode"];
}

- (void) setHdMode:(BOOL)value
{
	[[NSUserDefaults standardUserDefaults] setBool:value forKey:@"hdMode"];
}

- (float) imageQuality
{
	return [[NSUserDefaults standardUserDefaults] floatForKey:@"imageQuality"];
}

- (void) setImageQuality:(float)value
{
	[[NSUserDefaults standardUserDefaults] setFloat:value forKey:@"imageQuality"];
}

- (NSArray *) files
{
	return [NSFileManager filesInFolder:NSDocumentsFolder()];
}

@end

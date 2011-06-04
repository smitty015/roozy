//
//  LRAppModel.h
//  lifecycleRide
//
//  Created by Andy Roth on 1/17/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LRUser.h"
#import "Facebook.h"


@interface LRAppModel : NSObject
{
	NSManagedObjectContext *context;
	LRUser *user;
	Facebook *facebook;
}

@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain, readonly) LRUser *user;
@property (nonatomic, retain) Facebook *facebook;

+ (LRAppModel *) sharedModel;

@end

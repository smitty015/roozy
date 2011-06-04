//
//  ARRemoteImage.h
//  CommonLibraries
//
//  Created by Roth on 11/4/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARRemoteImage;

@protocol ARRemoteImageDelegate <NSObject>

- (void)remoteImageDidStartLoad:(ARRemoteImage *)remoteImage;
- (void)remoteImageDidComplete:(ARRemoteImage *)remoteImage;
- (void)remoteImageDidProgress:(ARRemoteImage *)remoteImage percent:(CGFloat)percent;
- (void)remoteImageDidFail:(ARRemoteImage *)remoteImage;

@end

@protocol ARRemoteImageDelegate;

@interface ARRemoteImage : UIImageView
{
	id <ARRemoteImageDelegate> delegate;
	NSString *_source;
	NSMutableData *_webData;
	NSURLConnection *_connection;
	BOOL _loadComplete;
	
	NSUInteger _totalSize;
}

@property (nonatomic, retain) id <ARRemoteImageDelegate> delegate;
@property (nonatomic, retain) NSString *source;

- (id) initWithSource:(NSString *)newSource withDelegate:(id <ARRemoteImageDelegate>)newDelegate;

@end

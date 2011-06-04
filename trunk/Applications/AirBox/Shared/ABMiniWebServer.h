//
//  ABMiniWebServer.h
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"


@interface ABMiniWebServer : NSObject <AsyncSocketDelegate>
{
	AsyncSocket *socket;
	int port;
}

@property (nonatomic, readonly) int port;

+ (ABMiniWebServer *) sharedServer;

- (void) start;
- (void) stop;
- (void) send404ToSocket:(AsyncSocket *)sock;

@end

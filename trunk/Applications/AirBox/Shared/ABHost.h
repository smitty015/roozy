//
//  ABHost.h
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ABHost : NSObject
{

}

+ (NSString *)addressForHostname:(NSString *)hostname;
+ (NSArray *)addressesForHostname:(NSString *)hostname;
+ (NSString *)hostnameForAddress:(NSString *)address;
+ (NSArray *)hostnamesForAddress:(NSString *)address;
+ (NSArray *)ipAddresses;
+ (NSArray *)ethernetAddresses;

+ (NSString *)firstIPAddress;

@end

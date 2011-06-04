//
//  ARJSONLoader.h
//  CommonLibraries
//
//  Created by Andrew Roth on 11/13/09.
//  Copyright 2009 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARJSONLoader;

@protocol ARJSONLoaderDelegate <NSObject>

/*
 * Called when the JSON loader has successfully received and parsed the results
 */
- (void)jsonLoader:(ARJSONLoader *)jsonLoader receivedResult:(id)result;
- (void)jsonLoader:(ARJSONLoader *)jsonLoader didProgress:(CGFloat)percent;
- (void)jsonLoader:(ARJSONLoader *)jsonLoader didFail:(BOOL)failed;

@end

@interface ARJSONLoader : NSObject
{
@private
	id <ARJSONLoaderDelegate> _delegate;
	NSMutableData *_webData;
	NSUInteger _totalSize;
}

// Public methods
- (id) initWithJSONDelegate:(id <ARJSONLoaderDelegate>) delegate;
- (void) loadWithURL:(NSString *)url;

@end

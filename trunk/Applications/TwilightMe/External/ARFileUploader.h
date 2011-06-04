//
//  ARImageUploader.h
//  CommonLibraries
//
//  Created by Roth on 12/3/09.
//  Copyright 2009 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ARFileUploader;

@protocol ARFileUploaderDelgate

- (void) fileUploader:(ARFileUploader *)uploader didSucceedWithResponse:(NSString *)response;
- (void) fileUploader:(ARFileUploader *)uploader didProgress:(CGFloat)progress;
- (void) fileUploader:(ARFileUploader *)uploader didFail:(NSString *)response;

@end


@interface ARFileUploader : NSObject
{
	id <ARFileUploaderDelgate> delegate;
	NSString *uploadServiceURI;
	
	NSMutableData *_webData;
	NSUInteger _totalSize;
}

@property (nonatomic, retain) id <ARFileUploaderDelgate> delegate;
@property (nonatomic, retain) NSString *uploadServiceURI;

- (id) initWithDelegate:(id<ARFileUploaderDelgate>)uploaderDelegate uploadServiceURI:(NSString *)uri;
- (void) uploadImage:(UIImage *)image;

@end

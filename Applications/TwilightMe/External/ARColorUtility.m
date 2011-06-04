
#import "ARColorUtility.h" 
#import "UIColor+ARExtended.h"

@implementation ARColorUtility  

-(id) initWithImage: (UIImage*) image  
{ 
	imageRef = [image CGImage];
	
	size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef); // 32
	size_t bytesPerPixel = bitsPerPixel / 8; // 4
	size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef); // 8
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
	
	// We'll be needing a chunk of memory to hold the rendered (alpha channel of the) image...  
	width = image.size.width;  
	int height = image.size.height;

	pixelData = malloc( width * height * bytesPerPixel );

	if( !pixelData )  
	{  
		NSException *exception = [NSException exceptionWithName:@"AlphaPixelsException"            
						reason:@"Unable to allocate memory for pixel data"    
						userInfo:nil];  
						@throw exception;
	}  

	CGContextRef context = CGBitmapContextCreate ( pixelData,
							width,
							height,
							bitsPerComponent,
							width * bytesPerPixel,
							colorSpace,            
							alphaInfo );

	if( !context )  
	{  
		NSException *exception = [NSException exceptionWithName:@"AlphaPixelsException"            
							reason:@"Unable to create bitmap context"    
							userInfo:nil];
							@throw exception;
	}

	// Render the image into the context (ending up in our buffer)  
	CGContextDrawImage( context, CGRectMake(0, 0, width, height), image.CGImage );
	CGContextRelease( context );  

	return self;  
}
   
-(NSString *) colorAtX:(int) x y:(int) y  
{  
	// Simple calculation to get the offset into the buffer for the coordinate values  
	// - but note these are all integer values. Floats representing sub-pixel values would  
	// need to be rounded before doing something similar  

	size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef); // 32
	size_t bytesPerPixel = bitsPerPixel / 8; // 4
	
	size_t bytesPerRow = width * bytesPerPixel;
	
	UInt8 r = pixelData[(y * bytesPerRow) + (x * bytesPerPixel) + 1];
	UInt8 g = pixelData[(y * bytesPerRow) + (x * bytesPerPixel) + 2];
	UInt8 b = pixelData[(y * bytesPerRow) + (x * bytesPerPixel) + 3];
	
	//NSLog([NSString stringWithFormat:@"Color is r:%X, g:%X, b:%X", r, g, b]);
	
	NSString *rHex = [NSString stringWithFormat:@"%X", r];
	NSString *gHex = [NSString stringWithFormat:@"%X", g];
	NSString *bHex = [NSString stringWithFormat:@"%X", b];
	
	while([rHex length] < 2)
	{
		rHex = [NSString stringWithFormat:@"0%@", rHex];
	}
	
	while([gHex length] < 2)
	{
		gHex = [NSString stringWithFormat:@"0%@", gHex];
	}
	
	while([bHex length] < 2)
	{
		bHex = [NSString stringWithFormat:@"0%@", bHex];
	}
	
	NSString *hexString = [NSString stringWithFormat:@"%@%@%@", rHex, gHex, bHex];
	
	return hexString;
}

+ (UIColor *) labelColorWithBackgroundHex: (NSString *) colorHex
{
	UIColor *color = [UIColor colorWithHexString:colorHex];
	
	// Use luminance calculation from COI to determine whether to display white or black label
	float luminance = [color luminance];
	
	if(luminance > 0.7)
	{
		return [UIColor darkGrayColor];
	}
	else
	{
		return [UIColor whiteColor];
	}
}

+ (NSString *) getRedFromHex: (NSString *)colorHex
{
	UIColor *color = [UIColor colorWithHexString:colorHex];
	
	return [NSString stringWithFormat:@"%i", [color red]];
}

+ (NSString *) getGreenFromHex: (NSString *)colorHex
{
	UIColor *color = [UIColor colorWithHexString:colorHex];
	
	return [NSString stringWithFormat:@"%i", [color green]];
}


+ (NSString *) getBlueFromHex: (NSString *)colorHex
{
	UIColor *color = [UIColor colorWithHexString:colorHex];
	
	return [NSString stringWithFormat:@"%i", [color blue]];
}

-(void) dealloc  
{  
	free( pixelData );
	[super dealloc];
} 

   
@end  
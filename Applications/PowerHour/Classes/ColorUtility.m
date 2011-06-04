
#import "ColorUtility.h"  

@implementation ColorUtility  

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
   
-(void) dealloc  
{  
	free( pixelData );
	[super dealloc];
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


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor clearColor];
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return [UIColor clearColor];
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}


+ (UIColor *) labelColorWithBackgroundHex: (NSString *) colorHex
{
	NSString *cString = [[colorHex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor darkGrayColor];
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return [UIColor darkGrayColor];
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	// Use luminance calculation from COI to determine whether to display white or black label
	float luminance = ((r * 0.2126) + (g * 0.7152) + (b * 0.0722)) * 0.00392157;
	
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
	NSString *cString = [[colorHex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return @"0";
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return @"0";
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	unsigned int intValue;
	[[NSScanner scannerWithString:rString] scanHexInt:&intValue];
	
	return [NSString stringWithFormat:@"%i", intValue];
}

+ (NSString *) getGreenFromHex: (NSString *)colorHex
{
	NSString *cString = [[colorHex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return @"0";
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return @"0";
	
	// Separate into r, g, b substrings
	NSRange range;
	range.length = 2;
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	unsigned int intValue;
	[[NSScanner scannerWithString:gString] scanHexInt:&intValue];
	
	return [NSString stringWithFormat:@"%i", intValue];
}


+ (NSString *) getBlueFromHex: (NSString *)colorHex
{
	NSString *cString = [[colorHex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return @"0";
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return @"0";
	
	// Separate into r, g, b substrings
	NSRange range;
	range.length = 2;
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	unsigned int intValue;
	[[NSScanner scannerWithString:bString] scanHexInt:&intValue];
	
	return [NSString stringWithFormat:@"%i", intValue];
}

   
@end  
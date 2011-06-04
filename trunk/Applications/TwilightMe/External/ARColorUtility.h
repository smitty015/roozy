
#import <UIKit/UIKit.h>

@interface ARColorUtility : NSObject
{
	UInt8* pixelData;
	int width;
	CGImageRef imageRef;
}

-(id) initWithImage: (UIImage*) image;
-(NSString *) colorAtX:(int) x y:(int) y;

+ (UIColor *) labelColorWithBackgroundHex: (NSString *) colorHex;

+ (NSString *) getRedFromHex: (NSString *)colorHex;
+ (NSString *) getGreenFromHex: (NSString *)colorHex;
+ (NSString *) getBlueFromHex: (NSString *)colorHex;

@end
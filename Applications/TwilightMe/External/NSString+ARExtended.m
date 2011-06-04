
#import "NSString+ARExtended.h"
#import "ARBase64Utility.h"


@implementation NSString (ARExtended)

- (BOOL) contains:(NSString *)insideString
{
	return ([self rangeOfString:insideString].location != NSNotFound);
}

- (NSString *) removeWhitespace
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) replaceString:(NSString *)replaced withString:(NSString *)withString
{
	if([self contains:replaced])
	{
		return [self stringByReplacingCharactersInRange:[self rangeOfString:replaced] withString:withString];
	}
	
	return self;
}

+ (NSString *)base64EncodedStringWithString:(NSString *)stringToEncode
{
	[ARBase64Utility initialize];
	return [ARBase64Utility encode:[stringToEncode dataUsingEncoding:NSUTF8StringEncoding]];
}

@end

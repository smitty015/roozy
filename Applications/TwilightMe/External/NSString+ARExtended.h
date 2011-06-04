
#import <Foundation/Foundation.h>


@interface NSString (ARExtended)

// Checks to see if the string contains another string
- (BOOL) contains:(NSString *)insideString;

// Removes extra whitespace and line breaks around a string
- (NSString *) removeWhitespace;

// Replaces part of a string with another string
- (NSString *) replaceString:(NSString *)replaced withString:(NSString *)withString;

+ (NSString *)base64EncodedStringWithString:(NSString *)stringToEncode;

@end

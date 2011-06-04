
#import <Foundation/Foundation.h>


@interface ARXMLAttribute : NSObject
{
	NSString *name;
	NSString *content;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *content;

+ (ARXMLAttribute *) attributeWithDictionary:(NSDictionary *)dictionary;

@end

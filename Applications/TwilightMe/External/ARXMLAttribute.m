
#import "ARXMLAttribute.h"


@implementation ARXMLAttribute

@synthesize name, content;

+ (ARXMLAttribute *) attributeWithDictionary:(NSDictionary *)dictionary
{
	ARXMLAttribute *newAttribute = [[ARXMLAttribute alloc] init];
	
	// Set name and content
	if([dictionary objectForKey:@"attributeName"] != nil) newAttribute.name = [dictionary objectForKey:@"attributeName"];
	if([dictionary objectForKey:@"attributeContent"] != nil) newAttribute.content = [dictionary objectForKey:@"attributeContent"];
	
	return newAttribute;
}

@end

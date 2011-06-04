
#import "ARXMLNode.h"
#import "ARXMLAttribute.h"
#import "NSString+ARExtended.h"

@implementation ARXMLNode

@synthesize name, content, attributes, children;

+ (ARXMLNode *) nodeWithDictionary:(NSDictionary *)dictionary
{
	ARXMLNode *newNode = [[ARXMLNode alloc] init];
	
	// Set name and content
	if([dictionary objectForKey:@"nodeName"] != nil) newNode.name = [dictionary objectForKey:@"nodeName"];
	if([dictionary objectForKey:@"nodeContent"] != nil) newNode.content = [dictionary objectForKey:@"nodeContent"];
	
	// Set the attributes
	newNode.attributes = [[NSMutableArray alloc] init];
	if([dictionary objectForKey:@"nodeAttributeArray"] != nil)
	{
		NSArray *tempAttributes = [dictionary objectForKey:@"nodeAttributeArray"];
		
		for(int i = 0; i < [tempAttributes count]; i++)
		{
			ARXMLAttribute *tempAttribute = [ARXMLAttribute attributeWithDictionary:[tempAttributes objectAtIndex:i]];
			[newNode.attributes addObject:tempAttribute];
		}
	}
	
	// Set the children
	newNode.children = [[NSMutableArray alloc] init];
	if([dictionary objectForKey:@"nodeChildArray"] != nil)
	{
		NSArray *tempChildren = [dictionary objectForKey:@"nodeChildArray"];
		
		for(int j = 0; j < [tempChildren count]; j++)
		{
			ARXMLNode *tempChild = [ARXMLNode nodeWithDictionary:[tempChildren objectAtIndex:j]];
			[newNode.children addObject:tempChild];
		}
	}
	
	return newNode;
}

- (ARXMLNode *) getChildNodeByName:(NSString *)childName
{
	for(int i = 0; i < [children count]; i++)
	{
		ARXMLNode *node = (ARXMLNode *)[children objectAtIndex:i];
		
		if([node.name isEqualToString:childName])
		{
			return node;
		}
	}
	
	return nil;
}

- (ARXMLNode *) getChildNodeThatContains:(NSString *)string
{
	for(int i = 0; i < [children count]; i++)
	{
		ARXMLNode *node = (ARXMLNode *)[children objectAtIndex:i];
		
		if([node.name contains:string])
		{
			return node;
		}
	}
	
	return nil;
}

- (ARXMLAttribute *) getAttributeByName:(NSString *)attributeName
{
	for(int i = 0; i < [attributes count]; i++)
	{
		ARXMLAttribute *attribute = (ARXMLAttribute *)[attributes objectAtIndex:i];
		
		if([attribute.name isEqualToString:attributeName])
		{
			return attribute;
		}
	}
	
	return nil;
}

@end

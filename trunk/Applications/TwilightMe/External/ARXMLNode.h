
#import <Foundation/Foundation.h>

@class ARXMLAttribute;

@interface ARXMLNode : NSObject
{
	// Main elements
	NSString *name;
	NSString *content;
	NSMutableArray *attributes;
	NSMutableArray *children;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSMutableArray *attributes;
@property (nonatomic, retain) NSMutableArray *children;

- (ARXMLNode *) getChildNodeByName:(NSString *)name;
- (ARXMLNode *) getChildNodeThatContains:(NSString *)string;
- (ARXMLAttribute *) getAttributeByName:(NSString *)name;

+ (ARXMLNode *) nodeWithDictionary:(NSDictionary *)dictionary;

@end

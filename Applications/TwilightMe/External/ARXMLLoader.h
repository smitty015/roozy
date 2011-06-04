/*
 
 ARXMLLoader
 
 This class provides a simple interface to load and parse XML documents.
 It accepts an XML URL, along with an XPath query to parse the results.  To receive everything, simply use '/'.
 
 To use:
 
 * Add '/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.0.sdk/usr/include/libxml2' to your Header Search Paths
 * Add '-lxml2' to your Other Linker Flags
 
 Each result in the array returns a ARXMLNode object.  Each ARXMLNode has the following properties:
 
 NSString *name;
 NSString *content;
 NSMutableArray *attributes;
 NSMutableArray *children;
 
 And 2 methods:
 
 - (ARXMLNode *) getChildByName:(NSString *)name;
 - (ARXMLAttribute *) getAttributeByName:(NSString *)name;
 
 Alternatively, the attributes and children arrays may be accessed directly.
 
 */

#import <Foundation/Foundation.h>

@class ARXMLLoader;

@protocol ARXMLLoaderDelegate <NSObject>

/*
 * Called when the xml loader has successfully received and parsed the results
 */
- (void)xmlLoader:(ARXMLLoader *)xmlLoader receivedResult:(NSMutableArray *)results;
- (void)xmlLoader:(ARXMLLoader *)xmlLoader didProgress:(CGFloat)percent;
- (void)xmlLoader:(ARXMLLoader *)xmlLoader didFail:(BOOL)failed;

@end

@interface ARXMLLoader : NSObject
{
@private
	id <ARXMLLoaderDelegate> _delegate;
	NSMutableData *_webData;
	NSString *_xPathQuery;
	NSString *_nsPrefix;
	NSString *_nsURI;
	NSUInteger _totalSize;
}

// Public methods
- (id) initWithDelegate:(id <ARXMLLoaderDelegate>) delegate;
- (void) loadWithURL:(NSString *)url xPathQuery:(NSString *)xPathQuery;
- (void) loadWithRequest:(NSMutableURLRequest *)request xPathQuery:(NSString *)xPathQuery;
- (void) setRootNamespace:(NSString *)prefix withURI:(NSString *)uri;

// Internal methods
- (void) performQuery:(NSString *)query;
- (NSMutableArray *) formatResults:(NSArray *)xmlResults;

@end


#import "ARXMLLoader.h"
#import "XPathQuery.h"
#import "ARXMLNode.h"


@implementation ARXMLLoader

- (id) initWithDelegate:(id <ARXMLLoaderDelegate>) delegate
{
	if(self = [super init])
	{
		_delegate = delegate;
	}
	
	return self;
}

- (void) loadWithURL:(NSString *)url xPathQuery:(NSString *)xPathQuery
{
	_xPathQuery = xPathQuery;
	NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	
	NSURL *realURL = [NSURL URLWithString:urlString];
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:realURL];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		_webData = [[NSMutableData data] retain];
	}
	else
	{
		[_delegate xmlLoader:self didFail:YES];
	}	
}

- (void) loadWithRequest:(NSMutableURLRequest *)request xPathQuery:(NSString *)xPathQuery
{
	_xPathQuery = xPathQuery;
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	NSLog(@"did it");
	
	if( theConnection )
	{
		_webData = [[NSMutableData data] retain];
	}
	else
	{
		[_delegate xmlLoader:self didFail:YES];
	}	
}

- (void) setRootNamespace:(NSString *)prefix withURI:(NSString *)uri
{
	_nsPrefix = prefix;
	_nsURI = uri;
}

- (void) performQuery:(NSString *)query
{
	if(_webData)
	{
		NSMutableArray *results = [self formatResults:PerformXMLXPathQuery(_webData, _xPathQuery, _nsPrefix, _nsURI)];
		
		if(_delegate)
		{
			[_delegate xmlLoader:self receivedResult:results];
		}
	}
}

/*
 NSURLConnectionDelegate
 */
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	_totalSize = (NSUInteger)[response expectedContentLength];
	[_webData setLength: 0];
}


-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_webData appendData:data];
	
	CGFloat percent = (float)[_webData length] / (float)_totalSize;
	if(_delegate) [_delegate xmlLoader:self didProgress:percent];
}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connection release];
	[_webData release];
	
	[_delegate xmlLoader:self didFail:YES];
}


-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSMutableArray *results = [self formatResults:PerformXMLXPathQuery(_webData, _xPathQuery, _nsPrefix, _nsURI)];
	
	if(_delegate)
	{
		[_delegate xmlLoader:self receivedResult:results];
	}
	
	[connection release];
}

- (NSMutableArray *) formatResults:(NSArray *)xmlResults
{
	NSMutableArray *newResults = [[NSMutableArray alloc] init];
	for(int i = 0; i < [xmlResults count]; i++)
	{
		ARXMLNode *newNode = [ARXMLNode nodeWithDictionary:[xmlResults objectAtIndex:i]];
		[newResults addObject:newNode];
	}
	
	return [newResults retain];
}


@end

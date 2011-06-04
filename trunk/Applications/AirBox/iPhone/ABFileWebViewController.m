//
//  ABPDFViewController.m
//  AirBox
//
//  Created by Andy Roth on 1/26/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABFileWebViewController.h"
#import "NSFileManager-Utilities.h"


@implementation ABFileWebViewController

@synthesize fileName;

- (void) viewDidLoad
{
	webView.backgroundColor = [UIColor blackColor];
	[self refresh];
}

- (void) refresh
{
	if(self.fileName)
	{
		NSString *fullPath = [NSString stringWithFormat:@"%@/%@", NSDocumentsFolder(), fileName];
		NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL fileURLWithPath:fullPath]];
		[webView loadRequest:request];
		[request release];
	}
	else
	{
		[webView loadHTMLString:@"" baseURL:nil];
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)dealloc
{
	[fileName release];
    [super dealloc];
}


@end

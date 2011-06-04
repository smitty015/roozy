//
//  ABPDFViewController.h
//  AirBox
//
//  Created by Andy Roth on 1/26/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ABFileWebViewController : UIViewController
{
	NSString *fileName;
	
	IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) NSString *fileName;

- (void) refresh;

@end

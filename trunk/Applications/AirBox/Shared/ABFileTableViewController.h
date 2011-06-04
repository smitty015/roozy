//
//  ABFileTableViewController.h
//  AirBox
//
//  Created by Andy Roth on 1/25/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABFileTableViewControllerDelegate <NSObject>

- (void) fileWasSelected:(NSString *)fileName;

@end


@interface ABFileTableViewController : UITableViewController
{
	id <ABFileTableViewControllerDelegate> delegate;
	NSArray *files;
}

@property (nonatomic, assign) id <ABFileTableViewControllerDelegate> delegate;

- (void) addRefreshButton;
- (void) refreshList;

@end

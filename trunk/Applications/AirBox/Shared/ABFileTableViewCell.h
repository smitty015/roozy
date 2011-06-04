//
//  ABFileTableViewCell.h
//  AirBox
//
//  Created by Andy Roth on 1/26/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ABFileTableViewCell : UITableViewCell
{
	UIImageView *iconView;
	UILabel *nameLabel;
}

- (void) setFilename:(NSString *)fileName;

@end

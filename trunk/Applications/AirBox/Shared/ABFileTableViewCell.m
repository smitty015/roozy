//
//  ABFileTableViewCell.m
//  AirBox
//
//  Created by Andy Roth on 1/26/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "ABFileTableViewCell.h"


@implementation ABFileTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
		iconView.contentMode = UIViewContentModeScaleAspectFit;
		[self.contentView addSubview:iconView];
		
		nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 280, 30)];
		nameLabel.opaque = NO;
		nameLabel.backgroundColor = [UIColor clearColor];
		nameLabel.font = [UIFont systemFontOfSize:14.0];
		[self.contentView addSubview:nameLabel];
		
    }
    return self;
}

- (void) setFilename:(NSString *)fileName
{
	nameLabel.text = fileName;
	
	NSArray *components = [fileName componentsSeparatedByString:@"."];
	NSString *extension = [components objectAtIndex:[components count]-1];
	
	if([extension isEqualToString:@"doc"] ||
	   [extension isEqualToString:@"docx"])
	{
		iconView.image = [UIImage imageNamed:@"Word.png"];
	}
	else if([extension isEqualToString:@"xls"] ||
			[extension isEqualToString:@"xlsx"])
	{
		iconView.image = [UIImage imageNamed:@"Excel.png"];
	}
	else if([extension isEqualToString:@"ppt"] ||
			[extension isEqualToString:@"pptx"])
	{
		iconView.image = [UIImage imageNamed:@"Powerpoint.png"];
	}
	else if([extension isEqualToString:@"pages"])
	{
		iconView.image = [UIImage imageNamed:@"Pages.png"];
	}
	else if([extension isEqualToString:@"numbers"])
	{
		iconView.image = [UIImage imageNamed:@"Numbers.png"];
	}
	else if([extension isEqualToString:@"key"])
	{
		iconView.image = [UIImage imageNamed:@"Keynote.png"];
	}
	else if([extension isEqualToString:@"jpg"] ||
			[extension isEqualToString:@"jpeg"] || 
			[extension isEqualToString:@"png"] || 
			[extension isEqualToString:@"gif"] || 
			[extension isEqualToString:@"tiff"] || 
			[extension isEqualToString:@"pdf"])
	{
		iconView.image = [UIImage imageNamed:@"Preview.png"];
	}
	else if([extension isEqualToString:@"mp4"] ||
			[extension isEqualToString:@"m4v"] || 
			[extension isEqualToString:@"mov"])
	{
		iconView.image = [UIImage imageNamed:@"Quicktime.png"];
	}
	else if([extension isEqualToString:@"mp3"] || 
			[extension isEqualToString:@"aac"] ||
			[extension isEqualToString:@"m4a"])
	{
		iconView.image = [UIImage imageNamed:@"Audio.png"];
	}
	else
	{
		iconView.image = [UIImage imageNamed:@"Unknown.png"];
	}
}

- (void)dealloc
{
	[iconView release];
	[nameLabel release];
	
    [super dealloc];
}


@end

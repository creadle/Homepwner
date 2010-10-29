//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomepwnerItemCell.h"
#import "Possession.h"


@implementation HomepwnerItemCell

- (id)initWithStyle:(UITableViewCellStyle)style 
	reuseIdentifier:(NSString *)reuseIdentifier 
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
	{
		valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		
		[[self contentView] addSubview:valueLabel];
		[valueLabel release];
		
		nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[[self contentView] addSubview:nameLabel];
		[nameLabel release];
		
		imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[[self contentView] addSubview:imageView];
		
		[imageView setContentMode:UIViewContentModeScaleAspectFit];
		[imageView release];
		[self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    return self;
}

- (void)accessoryViewTapped
{
	serialLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	[[self contentView] addSubview:serialLabel];
	[serialLabel release];
	
	dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	[[self contentView] addSubview:serialLabel];
	[serialLabel release];
	
	float inset = 5.0;
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	float valueWidth = 40.0;
	
	CGRect innerFrame = CGRectMake(inset, inset, h, h - inset * 2.0);
	[imageView setFrame:innerFrame];
	
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = w - (h + valueWidth + inset * 4.0);
	[serialLabel setFrame:innerFrame];
	
	
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = valueWidth;
	[dateLabel setFrame:innerFrame];	
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	float inset = 5.0;
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	float valueWidth = 40.0;
	
	CGRect innerFrame = CGRectMake(inset, inset, h, h - inset * 2.0);
	[imageView setFrame:innerFrame];
	
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = w - (h + valueWidth + inset * 4.0);
	[nameLabel setFrame:innerFrame];

	
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = valueWidth;
	[valueLabel setFrame:innerFrame];

}

- (void)setPossession:(Possession *)possession
{
	[valueLabel setText:[NSString stringWithFormat:@"$%d", [possession valueInDollars]]];
	[nameLabel setText:[possession possessionName]];
	[imageView setImage:[possession thumbnail]];
	[serialLabel setText:[possession serialNumber]];
	[dateLabel setText:[NSString stringWithFormat:@"$%d", [possession dateCreated]]];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end

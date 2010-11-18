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

@synthesize isAccessoryView, valueLabel, nameLabel;


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
		[self setIsAccessoryView:NO];
		
    } 
    return self;
}

- (void)accessoryViewTapped:(Possession *)possession
{
	
	if (isAccessoryView) {
		[valueLabel setText:[NSString stringWithFormat:@"$%d", [possession valueInDollars]]];
		[nameLabel setText:[possession possessionName]];
		[self setIsAccessoryView:NO];
	} else {
		[nameLabel setText:[NSString stringWithFormat:@"Created on: %d", [possession dateCreated]]];
		[valueLabel	setText:[NSString stringWithFormat:@"%d", [possession serialNumber]]];
		[self setIsAccessoryView:YES];
	}

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

	if (isAccessoryView) {
		[nameLabel setText:[NSString stringWithFormat:@"Created: %@", [possession dateCreated]]];
		[valueLabel	setText:[NSString stringWithFormat:@"%d", [possession serialNumber]]];
	} else {
		[valueLabel setText:[NSString stringWithFormat:@"$%d", [possession valueInDollars]]];
		[nameLabel setText:[possession possessionName]];
	}
	
	[imageView setImage:[possession thumbnail]];

 	

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end

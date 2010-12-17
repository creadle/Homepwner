//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HomepwnerItemCell.h"
#import <QuartzCore/QuartzCore.h>
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
		
		imageView = [[UIView alloc] initWithFrame:CGRectZero];
		[imageView setContentMode:UIViewContentModeScaleAspectFit];
		
		imageView.layer.masksToBounds = YES;
		imageView.layer.cornerRadius = 8.0;
		
		imageSubview = [[UIImageView alloc] initWithFrame:CGRectZero];
		[imageView addSubview:imageSubview];
		[imageSubview release];
		
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

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor,
						CGColorRef endColor)
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
	
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
	
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, 
														(CFArrayRef) colors, locations);
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	
	CGContextSaveGState(context);
	CGContextAddRect(context, rect);
	CGContextClip(context);
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(context);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
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
	[imageSubview setFrame:imageView.bounds];
	
/*	NSLog(@"Layer count %d", [[[imageView layer] sublayers] count]);
	
	glossyLayer = [[CAGradientLayer alloc] init];
	
	NSArray *colorsArray = [NSArray arrayWithObjects:
							(id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35] CGColor],
							(id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1] CGColor], nil]; 
	
	//[glossyLayer setBackgroundColor:[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.35] CGColor]];
	[glossyLayer setColors:colorsArray];
	[glossyLayer setOpacity:0.4];
	[glossyLayer setFrame:[[imageView layer] bounds]];
	
	if ([[[imageView layer] sublayers] count] < 2) {
		[[imageView layer] insertSublayer:glossyLayer atIndex: 2];
	}

	//[[imageView layer] insertSublayer:glossyLayer atIndex: 2];*/
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorRef glossColor1 = [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35] CGColor];
	CGColorRef glossColor2 = [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1] CGColor];
	
	CGRect topHalf = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, 
								imageView.frame.size.width, ((CGFloat)imageView.frame.size.height) / 2.0);
	
	drawLinearGradient(context, topHalf, glossColor1, glossColor2);
	
	
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
	
	[imageSubview setImage:[possession thumbnail]];

 	

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[glossyLayer release];
    [super dealloc];
}


@end

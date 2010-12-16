//
//  HomepwnerItemCell.h
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Possession;
@interface HomepwnerItemCell : UITableViewCell 
{
	UILabel *valueLabel;
	UILabel *nameLabel;
	UIView *imageView;
	UIImageView *imageSubview;
	UILabel *serialLabel;
	UILabel *dateLabel;
	BOOL isAccessoryView;
	CAGradientLayer *glossyLayer;
}

@property (nonatomic) BOOL isAccessoryView;
@property (nonatomic, assign) UILabel *valueLabel;
@property (nonatomic, assign) UILabel *nameLabel;

- (void)setPossession:(Possession *)possession;
- (void)accessoryViewTapped:(Possession *)possession;

@end

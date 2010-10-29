//
//  HomepwnerItemCell.h
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Possession;
@interface HomepwnerItemCell : UITableViewCell 
{
	UILabel *valueLabel;
	UILabel *nameLabel;
	UIImageView *imageView;
	UILabel *serialLabel;
	UILabel *dateLabel;

}

- (void)setPossession:(Possession *)possession;
- (void)accessoryViewTapped;

@end

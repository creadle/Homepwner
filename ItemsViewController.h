//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;

@interface ItemsViewController : UITableViewController 
{
	NSMutableArray *possessions;
	ItemDetailViewController *detailViewController;

}

@property (nonatomic, retain) NSMutableArray *possessions;
@end

//
//  HomepwnerAppDelegate.h
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemsViewController;

@interface HomepwnerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ItemsViewController *itemsViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end


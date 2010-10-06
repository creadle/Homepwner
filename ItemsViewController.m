    //
//  ItemsViewController.m
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "Possession.h"


@implementation ItemsViewController

- (id)init
{
	[super initWithStyle:UITableViewStyleGrouped];
	
	cheapPossessions = [[NSMutableArray alloc] init];
	expensivePossessions = [[NSMutableArray alloc] init];
	for (int i = 0; i < 10; i++) {
		Possession *possession = [Possession randomPossession];
		if ([possession valueInDollars] > 50) {
			[expensivePossessions addObject:possession];
			NSLog(@"Expensive possession added with value: %d", [possession valueInDollars]);
		}
		else {
			[cheapPossessions addObject:possession];
			NSLog(@"Cheap possession added with value: %d", [possession valueInDollars]);
		}

	}
	return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
	return [self init];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return [cheapPossessions count];
	}
	else {
		NSLog(@"Returning [expensivePossessions count].");
		return [expensivePossessions count];
	}

}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:@"UITableViewCell"] autorelease];
	}
	Possession *p;
	
	if ([indexPath section] == 0) {
		p = [cheapPossessions objectAtIndex:[indexPath row]];
	}
	else {
		p = [expensivePossessions objectAtIndex:[indexPath row]];
	}

	[[cell textLabel] setText:[p description]];
	return cell;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

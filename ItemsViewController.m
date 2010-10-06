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
	
	possessions = [[NSMutableArray alloc] init];
	for (int i = 0; i < 10; i++) {
		[possessions addObject:[Possession randomPossession]];
	}
	return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
	return [self init];
}

- (UIView *)headerView
{
	if (headerView) {
		return headerView;
	}
	
	UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	
	[editButton setTitle:@"Edit"
				forState:UIControlStateNormal];
	
	float w = [[UIScreen mainScreen] bounds].size.width;
	CGRect editButtonFrame = CGRectMake(8.0, 8.0, w - 16.0, 30.0);
	[editButton setFrame:editButtonFrame];
	
	[editButton addTarget:self
				   action:@selector(editingButtonPressed:)
		 forControlEvents:UIControlEventTouchUpInside];
	
	CGRect headerViewFrame = CGRectMake(0, 0, w, 48);
	headerView = [[UIView alloc] initWithFrame:headerViewFrame];
	[headerView addSubview:editButton];
	
	return headerView;
}

- (void)editingButtonPressed:(id)sender
{
	if ([self isEditing]) {
		[sender setTitle:@"Edit"
				forState:UIControlStateNormal];
		[self setEditing:NO
				animated:YES];
	}else {
		[sender setTitle:@"Done"
				forState:UIControlStateNormal];
		[self setEditing:YES
				animated:YES];
	}

}

- (void)setEditing:(BOOL)flag animated:(BOOL)animated
{
	[super setEditing:flag animated:animated];
	
	if (flag) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[possessions count] inSection:0];
		NSArray *paths = [NSArray arrayWithObject:indexPath];
		
		[[self tableView] insertRowsAtIndexPaths:paths
								withRowAnimation:UITableViewRowAnimationLeft];
	} else {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[possessions count]
													inSection:0];
		NSArray *paths = [NSArray arrayWithObject:indexPath];
		
		[[self tableView] deleteRowsAtIndexPaths:paths
								withRowAnimation:UITableViewRowAnimationFade];
	}

}

#pragma mark -
#pragma mark UITableView methods

- (BOOL)tableView:(UITableView *)tableview 
	canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath row] < [possessions count]) {
		return YES;
	}
	return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
	targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
	   toProposedIndexPath:(NSIndexPath	*)proposedDestinationIndexPath
{
	if ([proposedDestinationIndexPath row] < [possessions count]) {
		return proposedDestinationIndexPath;
	}
	NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[possessions count] - 1
													  inSection:0];
	return betterIndexPath;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
			  editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self isEditing] && [indexPath row] == [possessions count]) {
		return UITableViewCellEditingStyleInsert;
	}
	
	return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
	   toIndexPath:(NSIndexPath *)toIndexPath
{
	Possession *p = [possessions objectAtIndex:[fromIndexPath row]];
	[p retain];
	
	[possessions removeObjectAtIndex:[fromIndexPath row]];
	[possessions insertObject:p
					  atIndex:[toIndexPath row]];
	[p release];
}

- (void)tableView:(UITableView *)tableView
	commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
	 forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[possessions removeObjectAtIndex:[indexPath row]];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
						 withRowAnimation:UITableViewRowAnimationFade];
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		[possessions addObject:[Possession randomPossession]];
		[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						 withRowAnimation:UITableViewRowAnimationLeft];
	}
}
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
	int numberOfRows = [possessions count];
	if ([self isEditing]) {
		numberOfRows++;
	}
	
	return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:@"UITableViewCell"] autorelease];
	}
	
	if ([indexPath row] < [possessions count]) {
		Possession *p = [possessions objectAtIndex:[indexPath row]];
		[[cell textLabel] setText:[p description]];
	} else {
		[[cell textLabel] setText:@"Add New Item..."];
	}

	return cell;
}

- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)sec
{
	return [self headerView];
}

- (CGFloat)tableView:(UITableView *)tv heightForHeaderInSection:(NSInteger)sec
{
	return [[self headerView] frame].size.height;
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

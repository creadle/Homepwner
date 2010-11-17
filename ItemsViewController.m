    //
//  ItemsViewController.m
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "Possession.h"
#import "ItemDetailViewController.h"
#import "HomepwnerItemCell.h"


@implementation ItemsViewController
@synthesize possessions;

- (id)init
{
	[super initWithStyle:UITableViewStyleGrouped];
	
	[[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
	[[self navigationItem] setTitle:@"Homepwner"];
	
	return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
	return [self init];
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

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[[self tableView] reloadData];
}

#pragma mark -
#pragma mark UITableView methods

- (void)tableView:(UITableView *)tableView 
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	Possession *p = [possessions objectAtIndex:[indexPath row]];
	HomepwnerItemCell *cell = (HomepwnerItemCell *)[tableView cellForRowAtIndexPath:indexPath];
	[cell accessoryViewTapped:p];
		
	NSArray *indexArray = [[NSArray alloc]initWithObjects:indexPath, nil];
		
	[tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationRight];
	[indexArray release];

}

- (void)tableView:(UITableView *)aTableView
	didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (!detailViewController) {
		detailViewController = [[ItemDetailViewController alloc] init];
	}
	
	[detailViewController setEditingPossession:[possessions objectAtIndex:[indexPath row]]];
	
	[[self navigationController] pushViewController:detailViewController
										   animated:YES];
}

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
	if ([indexPath row] >= [possessions count]) {
		UITableViewCell *basicCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
		
		if (!basicCell) {
			basicCell = [[[UITableViewCell alloc]
						  initWithStyle:UITableViewCellStyleDefault
						  reuseIdentifier:@"UITableViewCell"] autorelease];
		}
		
		[[basicCell textLabel] setText:@"Add New Item..."];
		return basicCell;
	}
	
	HomepwnerItemCell *cell = (HomepwnerItemCell *)[tableView dequeueReusableCellWithIdentifier:@"HomepwnerItemCell"];
	
	
	if (!cell) {
		cell = [[[HomepwnerItemCell alloc] initWithStyle:UITableViewCellStyleDefault
										 reuseIdentifier:@"HomepwnerItemCell"] autorelease];
	}
	
	Possession *p = [possessions objectAtIndex:[indexPath row]];
	[cell setPossession:p];
	
	return cell;
}

#pragma mark -
#pragma mark Cleanup

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

//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"
#import "ImageCache.h"


@implementation ItemDetailViewController

@synthesize editingPossession;

- (id)init 
{
	[super initWithNibName:@"ItemDetailViewController" bundle:nil];
	
	UIBarButtonItem *cameraBarButtonItem = 
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
													  target:self
													  action:@selector(takePicture:)];
	[[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
	[cameraBarButtonItem release];
	
	return self;
}

- (void)takePicture:(id)sender
{
	[[self view] endEditing:YES];
	
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
	} else {
		[imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	}
	[imagePicker setDelegate:self];
	
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSString *oldKey = [editingPossession imageKey];
	
	if (oldKey) {
		[[ImageCache sharedImageCache] deleteImageForKey:oldKey];
	}
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
	
	[editingPossession setImageKey:(NSString *)newUniqueIDString];
	
	CFRelease(newUniqueIDString);
	CFRelease(newUniqueID);
	
	[[ImageCache sharedImageCache] setImage:image 
									 forKey:[editingPossession imageKey]];
	
	[imageView setImage:image];
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (IBAction)deleteButtonPressed:(id)sender
{
	NSString *deleteKey = [editingPossession imageKey];
	
	if (deleteKey) {
		[[ImageCache sharedImageCache] deleteImageForKey:deleteKey];
		[editingPossession setImageKey:nil];
		[imageView setImage:nil];
	}
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[nameField setText:[editingPossession possessionName]];
	[serialNumberField setText:[editingPossession serialNumber]];
	[valueField setText:[NSString stringWithFormat:@"%d", [editingPossession valueInDollars]]];
	
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	[dateLabel setText:[dateFormatter stringFromDate:[editingPossession dateCreated]]];
	
	[[self navigationItem] setTitle:[editingPossession possessionName]];
	
	NSString *imageKey = [editingPossession imageKey];
	
	if (imageKey) {
		UIImage *imageToDisplay = [[ImageCache sharedImageCache] imageForKey:imageKey];
		[imageView setImage:imageToDisplay];
	}else {
		[imageView setImage:nil];
	}

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[nameField resignFirstResponder];
	[serialNumberField resignFirstResponder];
	[valueField resignFirstResponder];
	
	[editingPossession setPossessionName:[nameField text]];
	[editingPossession setSerialNumber:[serialNumberField text]];
	[editingPossession setValueInDollars:[[valueField text] intValue]];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
	
	[nameField release];
	nameField = nil;
	[serialNumberField release];
	serialNumberField = nil;
	[valueField release];
	valueField = nil;
	[dateLabel release];
	dateLabel = nil;
	[imageView release];
	imageView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nameField release];
	[serialNumberField release];
	[valueField release];
	[dateLabel release];
	[imageView release];
    [super dealloc];
	}


@end

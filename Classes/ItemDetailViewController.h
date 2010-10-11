//
//  ItemDetailViewController.h
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Possession;

@interface ItemDetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
	IBOutlet UITextField *nameField;
	IBOutlet UITextField *serialNumberField;
	IBOutlet UITextField *valueField;
	IBOutlet UILabel *dateLabel;
	IBOutlet UIImageView *imageView;
	
	Possession *editingPossession;

}

@property (nonatomic, assign) Possession *editingPossession;

@end

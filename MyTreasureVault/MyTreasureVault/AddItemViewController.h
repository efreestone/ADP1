// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  AddItemViewController.h
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/12/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *editedImageView;

//Declare IBActions for save and cancel buttons
-(IBAction)onCancel:(id)sender;
-(IBAction)onSave:(id)sender;

//Declare onClick for camera button
-(IBAction)onClick:(id)sender;

@end

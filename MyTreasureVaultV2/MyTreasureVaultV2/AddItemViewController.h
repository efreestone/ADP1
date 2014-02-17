// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  AddItemViewController.h
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//Declare IBActions for save and cancel buttons
-(IBAction)onCancel:(id)sender;
-(IBAction)onSave:(id)sender;

//Declare onClick for camera button
-(IBAction)onClick:(id)sender;

@end
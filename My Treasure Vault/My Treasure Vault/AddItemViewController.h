// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  AddItemViewController.h
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    //Declare formatted date
    NSString *formattedDate;
}

//Declare IBOutlets for text fields
@property (strong, nonatomic) IBOutlet UITextField *makeTextField;
@property (strong, nonatomic) IBOutlet UITextField *modelTextField;
@property (strong, nonatomic) IBOutlet UITextField *serialTextField;
@property (strong, nonatomic) IBOutlet UITextField *detailsTextField;
@property (strong, nonatomic) IBOutlet UITextField *costTextField;
//Declare switch for sync
@property (strong, nonatomic) IBOutlet UISwitch *syncSwitch;

//Declare passed managed object
@property (strong, nonatomic) NSManagedObject *passedManagedObject;
//Declare passed image url
@property (strong, nonatomic) NSURL *passedImageURL;

//Declare IBActions for save and cancel buttons
-(IBAction)onCancel:(id)sender;
-(IBAction)onSave:(id)sender;

//Declare onClick for camera button
-(IBAction)onClick:(id)sender;

@end

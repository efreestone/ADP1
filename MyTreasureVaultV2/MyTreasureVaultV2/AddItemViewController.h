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

@property (strong, nonatomic) NSManagedObject *passedManagedObject;

//Declare IBActions for save and cancel buttons
-(IBAction)onCancel:(id)sender;
-(IBAction)onSave:(id)sender;

//Declare onClick for camera button
-(IBAction)onClick:(id)sender;

@end
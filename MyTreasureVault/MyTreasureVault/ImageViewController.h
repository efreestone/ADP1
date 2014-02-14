// Elijah Freestone
// ADP1 1402
// My Treasure Vault
// February 10th, 2014

//
//  ImageViewController.h
//  MyTreasureVault
//
//  Created by Elijah Freestone on 2/13/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

//Declare passed image
@property (strong, nonatomic) UIImage *passedNewImage;

//Declare UIImage and buttons
@property (strong, nonatomic) IBOutlet UIImageView *editedImageView;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

//Declare IBAction for buttons
-(IBAction)onSave:(id)sender;
-(IBAction)onCancel:(id)sender;

@end

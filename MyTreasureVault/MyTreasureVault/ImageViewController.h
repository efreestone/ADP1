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

@property (strong, nonatomic) UIImage *passedNewImage;

@property (strong, nonatomic) IBOutlet UIImageView *editedImageView;

@end

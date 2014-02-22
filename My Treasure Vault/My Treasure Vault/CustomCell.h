// Elijah Freestone
// ADP1 1402
// Week 4
// My Treasure Vault Final
// February 21st, 2014

//
//  CustomCell.h
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/21/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

//Declare image view
@property (strong, nonatomic) IBOutlet UIImageView *cellImage;
//Declare item make/model label
@property (strong, nonatomic) IBOutlet UILabel *makeModelLabel;
//Declare item details label
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;
//Declare date added label
@property (strong, nonatomic) IBOutlet UILabel *dateAddedLabel;

@end

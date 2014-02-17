// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  CustomCell.m
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

//Synthesize for getter/setter
@synthesize cellImage, makeModelLabel, detailsLabel, dateAddedLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  RecentItems.h
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentItems : NSObject

//Declare strings for item info
@property (nonatomic, copy) UIImage *imageOne;
@property (nonatomic, copy) NSString *itemMake;
@property (nonatomic, copy) NSString *itemModel;
@property (nonatomic, copy) NSString *itemSerial;
@property (nonatomic, copy) NSString *itemDetails;
@property (nonatomic, copy) NSString *itemCost;
@property (nonatomic, copy) NSString *dateAdded;

@end

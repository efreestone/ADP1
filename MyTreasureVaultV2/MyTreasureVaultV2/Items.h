// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  Items.h
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/18/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Items : NSManagedObject

@property (nonatomic, retain) NSString * cost;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * serial;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSString * formattedDate;

@end

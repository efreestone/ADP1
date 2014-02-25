//
//  Items.h
//  My Treasure Vault
//
//  Created by Elijah Freestone on 2/24/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Items : NSManagedObject

@property (nonatomic, retain) NSString * cost;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * formattedDate;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * serial;
@property (nonatomic, retain) NSData * imageData;

@end

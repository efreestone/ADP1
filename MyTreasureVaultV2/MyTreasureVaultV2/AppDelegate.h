// Elijah Freestone
// ADP1 1402
// Week 3
// My Treasure Vault Version 2
// February 15th, 2014

//
//  AppDelegate.h
//  MyTreasureVaultV2
//
//  Created by Elijah Freestone on 2/17/14.
//  Copyright (c) 2014 Elijah Freestone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//Declare BOOL to add in filling default date
@property (nonatomic, readwrite) BOOL databaseExists;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

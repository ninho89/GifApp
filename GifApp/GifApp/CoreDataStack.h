//
//  CoreDateStack.h
//  Week4Day2CoreData
//
//  Created by Filippo Aresu on 24/2/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (instancetype)initWithModelName:(NSString *)modelName;


@end

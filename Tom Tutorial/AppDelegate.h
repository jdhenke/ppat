//
//  AppDelegate.h
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/8/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WFConnector/WFConnector.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, WFHardwareConnectorDelegate> {
    WFHardwareConnector* hardwareConnector;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

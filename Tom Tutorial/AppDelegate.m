//
//  AppDelegate.m
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/8/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate (_PRIVATE_)

- (void)copyPlistToDocs;

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // create ui storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [mainStoryboard instantiateInitialViewController];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // configure the hardware connector.
    hardwareConnector = [WFHardwareConnector sharedConnector];
    hardwareConnector.delegate = self;
	hardwareConnector.sampleRate = 0.5;  // sample rate 500 ms, or 2 Hz.
    //
    // determine support for BTLE.
    if ( hardwareConnector.hasBTLESupport )
    {
        // enable BTLE.
        [hardwareConnector enableBTLE:TRUE];
    }
    NSLog(@"%@", hardwareConnector.hasBTLESupport?@"DEVICE HAS BTLE SUPPORT":@"DEVICE DOES NOT HAVE BTLE SUPPORT");
    
    // set HW Connector to call hasData only when new data is available.
    [hardwareConnector setSampleTimerDataCheck:YES];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

////// SETUP FOR WAHOO
#pragma mark -
#pragma mark HardwareConnectorDelegate Implementation

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector connectedSensor:(WFSensorConnection*)connectionInfo
{
    NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              connectionInfo, @"connectionInfo",
                              nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:WF_NOTIFICATION_SENSOR_CONNECTED object:nil userInfo:userInfo];
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector didDiscoverDevices:(NSSet*)connectionParams searchCompleted:(BOOL)bCompleted
{
    // post the sensor type and device params to the notification.
    NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              connectionParams, @"connectionParams",
                              [NSNumber numberWithBool:bCompleted], @"searchCompleted",
                              nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:WF_NOTIFICATION_DISCOVERED_SENSOR object:nil userInfo:userInfo];
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector disconnectedSensor:(WFSensorConnection*)connectionInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:WF_NOTIFICATION_SENSOR_DISCONNECTED object:nil];
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector stateChanged:(WFHardwareConnectorState_t)currentState
{
	BOOL connected = ((currentState & WF_HWCONN_STATE_ACTIVE) || (currentState & WF_HWCONN_STATE_BT40_ENABLED)) ? TRUE : FALSE;
	if (connected)
	{
        [[NSNotificationCenter defaultCenter] postNotificationName:WF_NOTIFICATION_HW_CONNECTED object:nil];
	}
	else
	{
        [[NSNotificationCenter defaultCenter] postNotificationName:WF_NOTIFICATION_HW_DISCONNECTED object:nil];
	}
}

//--------------------------------------------------------------------------------
- (void)hardwareConnectorHasData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:WF_NOTIFICATION_SENSOR_HAS_DATA object:nil];
}


#pragma mark -
#pragma mark WahooDemoAppDelegate Implementation

#pragma mark Private Methods

//--------------------------------------------------------------------------------
- (void)copyPlistToDocs
{
	// First, test for existence - we don’t want to wipe out a user’s DB
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:WF_SENSOR_DATA_FILE];
	
	// for debugging, uncomment this line to overwrite existing copy.
	// DEBUG:  overwrite existing settings file.
	//[[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
	
	if ( ![fileManager fileExistsAtPath:filePath] )
	{
		// The writable database does not exist, so copy the default to the appropriate location.
		NSString *templatePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:WF_SENSOR_DATA_FILE];
		
		NSError* error;
		
		BOOL success = [fileManager copyItemAtPath:templatePath toPath:filePath error:&error];
		
		if (!success)
        {
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
		}
	}
}

@end

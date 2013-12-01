//
//  LastWorkoutConfigViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 12/1/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "LastWorkoutConfigViewController.h"
#import "AppDelegate.h"
#import "WorkoutProgressViewController.h"
#import "AudioIntervalTimeViewController.h"

@interface LastWorkoutConfigViewController ()

@end

@implementation LastWorkoutConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"WorkoutSettings"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    
    if ([results count] > 0)
    {
        self.workoutSettings = [results objectAtIndex:0];
        NSString *audioMetricsString = [NSString stringWithFormat:@"Audio metrics on: %@", [self.workoutSettings getAudioMetrics]];
        NSString *timeIntervalString = [NSString stringWithFormat:@"Time interval: %@", [self.workoutSettings getTimeIntervalText]];
        self.audioMetrics.text = audioMetricsString;
        self.audioTimeInterval.text = timeIntervalString;
    }
    else
    {
        // TODO: no previous workouts to choose from....
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.workoutSettings) {
//        if ([segue.identifier isEqualToString:@"AdjustTimeIntervalSegue"]) {
//            AudioIntervalTimeViewController *audioIntervalTimeViewController = (AudioIntervalTimeViewController *)segue.destinationViewController;
//            audioIntervalTimeViewController.workoutSettings = self.workoutSettings;
//            
//        }
        if ([segue.identifier isEqualToString:@"StartWorkoutSegue"]) {
            UINavigationController *navigationController = segue.destinationViewController;
            WorkoutProgressViewController *workoutProgressViewController = [[navigationController viewControllers] objectAtIndex:0];
            
            workoutProgressViewController.workoutSettings = self.workoutSettings;
        }
    }
}

@end

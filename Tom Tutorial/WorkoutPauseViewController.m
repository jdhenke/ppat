//
//  WorkoutPauseViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/11/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutPauseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Workout.h"

@interface WorkoutPauseViewController ()

@end

@implementation WorkoutPauseViewController

@synthesize delegate;
@synthesize workout;
@synthesize timeElapsed;

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

    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Paused"];
    [av speakUtterance:utterance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resume:(id)sender
{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Resuming Workout"];
    [av speakUtterance:utterance];
	[self.delegate workoutPauseViewControllerDidResume:self];
}

- (IBAction)read:(id)sender
{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"how now brown cow - what's good yo? alpha bravo charlie delta."];
    [av speakUtterance:utterance];
}

- (IBAction)endWorkout:(id)sender
{
    // save workout
}

-(void)saveWorkout
{
    //    NSManagedObjectContext *context = [self managedObjectContext];
    //    NSManagedObject *workout = [NSEntityDescription
    //                                insertNewObjectForEntityForName:@"Workout"
    //                                inManagedObjectContext: context];
    //    [workout setValue:timeElapsed forKey:@"totalTime"];
    workout.totalTime = &(timeElapsed); // Xcode made me add the &
    workout.date = [NSDate date];
    
    NSError *error = nil;
    
	if (![workout.managedObjectContext save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
}

@end

//
//  WorkoutProgressViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutProgressViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <math.h>
#import "AppDelegate.h"
#import "Workout.h"

@interface WorkoutProgressViewController ()

@end

@implementation WorkoutProgressViewController

@synthesize clock, heartRate, pauseResumeButton;

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
    
    // wait for voiceover to shut up
    while ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
        // do nothing
    }

    // Announce that the workout has started.
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Started"];
    [av speakUtterance:utterance];

    
    // Update the clock.
    lastElapsed = 0;
    clock.text = @"Time Elapsed: 0 seconds";
    timeIntervalReading = 10;
    
    // Update the heart rate.
    heartRate.text = @"Heart Rate: 0 beats per minute";
    [self startClock];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateHeartRate {
    //TODO(mwchen): Update this when the heart rate monitor is connected.
}

- (void)updateTime
{
    if (running == false) return;

    NSTimeInterval elapsed = [self getTotalTimeElapsed];

    int mins = (int) (elapsed / 60.0);
    int secs = (int) (elapsed - mins * 60);
    
    clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%02u", mins, secs];
    
    // If the time is at the time interval specified, read the interval information out loud.
    if (secs%timeIntervalReading ==0 && secs > 5) {
        [self readIntervalWithTime:elapsed];
    }
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}

- (NSString *)getSpokenTime:(NSTimeInterval)elapsed
{
    int mins = (int) (elapsed / 60.0);
    int secs = (int) (elapsed - mins * 60);
    
    NSString *minuteText;
    if (mins == 1) {
        minuteText = [NSString stringWithFormat: @"minute"];
    } else {
        minuteText = [NSString stringWithFormat: @"minutes"];
    }
    
    NSString *secondText;
    if (secs == 1) {
        secondText = [NSString stringWithFormat: @"second"];
    } else {
        secondText = [NSString stringWithFormat: @"seconds"];
    }
    
    const char *minuteChars = [minuteText UTF8String];
    const char *secondChars = [secondText UTF8String];
    
    return [NSString stringWithFormat: @"Time Elapsed: %u %s and %02u %s", mins, minuteChars, secs, secondChars];
}

- (void)readIntervalWithTime:(NSTimeInterval)elapsed
{
    
    // wait for voiceover to shut up
    while ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
        // do nothing
    }
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *timeUtterance = [[AVSpeechUtterance alloc]initWithString:[self getSpokenTime:elapsed]];
    [av speakUtterance:timeUtterance];
    AVSpeechUtterance *HRUtterance = [[AVSpeechUtterance alloc]initWithString:heartRate.text];
    [av speakUtterance:HRUtterance];
}

- (NSTimeInterval)getTotalTimeElapsed
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    return lastElapsed + currentTime - startTime;
}

- (void)pauseWorkout
{
    running = false;
    lastElapsed = [self getTotalTimeElapsed];
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Pausing Workout"];
    [av speakUtterance:utterance];
}

- (void)startClock
{
    running = true;
    startTime = [NSDate timeIntervalSinceReferenceDate];

    [self updateTime];
}

- (void)resumeWorkout
{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Resuming Workout"];
    [av speakUtterance:utterance];
	[self startClock];
}

- (IBAction)pauseOrResumeWorkout:(id)sender
{
    if (running) {
        [self pauseWorkout];
        [self.pauseResumeButton setTitle:@"Resume" forState:UIControlStateNormal];
    } else {
        [self resumeWorkout];
        [self.pauseResumeButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (IBAction)endWorkout:(id)sender
{
    // save workout
    running = false;
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *endUtterance = [[AVSpeechUtterance alloc]initWithString:@"Ending Workout"];
    [av speakUtterance:endUtterance];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EndWorkout"])
    {
        // TODO: should it be embedded in NavigationController so it's a modal?
        UINavigationController *navigationController = segue.destinationViewController;
        WorkoutSummaryViewController *workoutSummaryViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        // pass the workout into next controller
//        WorkoutSummaryViewController *workoutSummaryViewController = (WorkoutSummaryViewController *)segue.destinationViewController;
        workoutSummaryViewController.workout = [self createWorkout];
    }
}

-(Workout *)createWorkout
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    NSManagedObject *workout = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
    NSNumber *totalTime = [NSNumber numberWithDouble:[self getTotalTimeElapsed]];
    
    [workout setValue:totalTime forKey:@"totalTime"];
    [workout setValue:[NSDate date] forKey:@"date"];
    NSError *error = nil;
    
	if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    return (Workout *)workout;
}


@end

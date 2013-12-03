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

@synthesize clock, heartRate, pauseResumeButton, savedSender;

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
    
//    // wait for voiceover to shut up
//    while ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
//        // do nothing
//    }
    
    // Announce that the workout has started.
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Started"];
    [av speakUtterance:utterance];

    
    // Update the clock.
    lastElapsed = 0;
    clock.text = @"Time Elapsed: 0 seconds";
    clock.accessibilityLabel = clock.text;
    
    // Update the heart rate.
    heartRate.text = @"Heart rate monitor is not connected.";
    heartRate.accessibilityLabel = heartRate.text;
    [self startClock];
    
    self.pauseResumeButton.accessibilityLabel = @"Pause";
    NSLog([NSString stringWithFormat: @"Time audio interval: %d", self.workoutSettings.timeAudioInterval]);
    
    // Set the default average heart rate
    averageHeartRate = 0;
    totalBeatsOverTime = 0;
    numTimeSampleHR = 0;

}

-(void) viewDidAppear:(BOOL)animated
{
    // Start listeninig for data
    // register for HW connector notifications.
}

-(void) viewDidDisappear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime
{
    if (running == false) return;

    NSTimeInterval elapsed = [self getTotalTimeElapsed];

    int mins = (int) (elapsed / 60.0);
    int secs = (int) (elapsed - mins * 60);
    int hours = (int) mins / 60;
    
    if (hours == 0) {
        clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%02u", mins, secs];
    } else {
        mins %= 60;
        clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%u:%02u", hours, mins, secs];
    }

    clock.accessibilityLabel = [self getSpokenTime:elapsed];
    
    // If the time is at the time interval specified, read the interval information out loud.
    if (self.workoutSettings.timeAudioInterval > 0 && (int)elapsed%(int)self.workoutSettings.timeAudioInterval ==0 && secs > 5) {
        [self readIntervalWithTime:elapsed];
    }
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
    
    // Update the average heart rate
    [self calculateAverageHeartRate];
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
    if (self.workoutSettings.timeAudioOn) {
        AVSpeechUtterance *timeUtterance = [[AVSpeechUtterance alloc]initWithString:[self getSpokenTime:elapsed]];
        [av speakUtterance:timeUtterance];
    }
    if (self.workoutSettings.heartRateAudioOn) {
        AVSpeechUtterance *HRUtterance = [[AVSpeechUtterance alloc]initWithString:heartRate.text];
        [av speakUtterance:HRUtterance];
    }
}

- (NSTimeInterval)getTotalTimeElapsed
{
    if (running) {
        NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
        return lastElapsed + currentTime - startTime;
    } else {
        return lastElapsed;
    }
}

- (void)pauseWorkout
{
    [self pauseClock];
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Pausing Workout"];
    [av speakUtterance:utterance];
    
    // Stop listening for heart rate information.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pauseClock
{
    lastElapsed = [self getTotalTimeElapsed];
    running = false;
}

- (void)startClock
{
    running = true;
    startTime = [NSDate timeIntervalSinceReferenceDate];
    
    [self updateTime];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeartRate:) name:@"HeartRate" object:nil];
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
        [self.pauseResumeButton setTitle:@"Resume Workout" forState:UIControlStateNormal];
        self.pauseResumeButton.accessibilityLabel = @"Resume Workout";
    } else {
        [self resumeWorkout];
        [self.pauseResumeButton setTitle:@"Pause Workout" forState:UIControlStateNormal];
        self.pauseResumeButton.accessibilityLabel = @"Pause Workout";
    }
}

- (IBAction)endWorkout:(id)sender
{
    [self pauseClock];
    self.savedSender = sender;
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"End Workout Confirmation"
                                                      message:@"Do you want to end this workout?"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Definitely End Workout", @"Cancel", nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
        AVSpeechUtterance *endUtterance = [[AVSpeechUtterance alloc]initWithString:@"Ending Workout"];
        [av speakUtterance:endUtterance];
        [self performSegueWithIdentifier:@"EndWorkout" sender:self.savedSender];
    } else {
        [self resumeWorkout];
    }
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
    [workout setValue:[NSNumber numberWithInteger:averageHeartRate] forKey:@"avgHeartRate"];
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

- (void) updateHeartRate:(NSNotification *)hrData {
    NSDictionary *dataDict = [hrData userInfo];
    NSLog(@"trying to log heart rate");
    if (dataDict !=nil) {
        heartRateData = [dataDict objectForKey:@"heartRateData"];
        heartRate.text = [NSString stringWithFormat:@"Heart Rate: %@",[heartRateData formattedHeartrate:TRUE]];
        heartRate.accessibilityLabel = heartRate.text;
        NSLog(@"Current heart rate: %@", [heartRateData formattedHeartrate:TRUE]);
    }
}

- (void) calculateAverageHeartRate{
    if (heartRateData !=nil) {
        NSInteger computedHR =(NSInteger)[heartRateData computedHeartrate];
        totalBeatsOverTime = totalBeatsOverTime + computedHR;
        numTimeSampleHR = numTimeSampleHR + 1;
        averageHeartRate = totalBeatsOverTime/numTimeSampleHR;
        NSLog(@"Average Heart Rate: %d", averageHeartRate);
    }
}




@end

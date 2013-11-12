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

@interface WorkoutProgressViewController ()

@end

@implementation WorkoutProgressViewController

@synthesize clock, heartRate;

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

    // Update the heart rate.
    heartRate.text = @"Heart Rate: 0 beats per minute";
    
    // Update the clock.
    lastElapsed = 0;
    clock.text = @"Time Elapsed: 00:00";
    timeIntervalReading = 10;
    [self startClock];

    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Started"];
    [av speakUtterance:utterance];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateHeartRate {
    //heartRate.text = [
}

- (void)updateTime
{
    if (running == false) return;

    NSTimeInterval elapsed = [self getTotalTimeElapsed];

    int mins = (int) (elapsed / 60.0);
    int secs = (int) (elapsed - mins * 60);
    
//    NSLog(@"%d", secs%timeIntervalReading);
    if (secs%timeIntervalReading ==0) {
        [self readInterval];
    }

    clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%02u", mins, secs];

    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}

- (void)readInterval{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *HRUtterance = [[AVSpeechUtterance alloc]initWithString:heartRate.text];
    [av speakUtterance:HRUtterance];
    AVSpeechUtterance *timeUtterance = [[AVSpeechUtterance alloc]initWithString:clock.text];
    [av speakUtterance:timeUtterance];
}

- (NSTimeInterval)getTotalTimeElapsed
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    return lastElapsed + currentTime - startTime;
}

- (void)pauseClock
{
    running = false;
    lastElapsed = [self getTotalTimeElapsed];
}

- (void)startClock
{
    running = true;
    startTime = [NSDate timeIntervalSinceReferenceDate];

    [self updateTime];
}

- (void)workoutPauseViewControllerDidResume:
(WorkoutPauseViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self startClock];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PauseWorkout"])
    {
        [self pauseClock];
        UINavigationController *navigationController = segue.destinationViewController;
        WorkoutPauseViewController *workoutPauseViewController = [[navigationController viewControllers] objectAtIndex:0];
        workoutPauseViewController.delegate = self;
        workoutPauseViewController.timeElapsed = lastElapsed;
    }
}


@end

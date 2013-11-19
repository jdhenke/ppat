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
    
    // If the time is at the time interval specified, read the interval information out loud.
    if (secs%timeIntervalReading ==0) {
        [self readInterval];
    }

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

    clock.text = [NSString stringWithFormat: @"Time Elapsed: %u %s and %02u %s", mins, minuteChars, secs, secondChars];

    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}

- (void)readInterval{
    
    // wait for voiceover to shut up
    while ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
        // do nothing
    }
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *timeUtterance = [[AVSpeechUtterance alloc]initWithString:clock.text];
    [av speakUtterance:timeUtterance];
    AVSpeechUtterance *HRUtterance = [[AVSpeechUtterance alloc]initWithString:heartRate.text];
    [av speakUtterance:HRUtterance];
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

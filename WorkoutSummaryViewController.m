//
//  WorkoutSummaryViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/12/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutSummaryViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Workout.h"
#import "AppDelegate.h"

@interface WorkoutSummaryViewController ()

@end

@implementation WorkoutSummaryViewController

@synthesize workout;

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
    NSLog(@"workout time: %@", self.workout.totalTime);
    self.totalTime.text = [self stringFromTimeInterval:(self.workout.totalTime)];
    self.totalTime.accessibilityLabel = [self getSpokenTime:self.workout.totalTime];
    
    NSString *heartRateText = @"Heart Rate: 120 beats per minute";
    self.heartRate.text = heartRateText;
    self.heartRate.accessibilityLabel = heartRateText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO: put this in a helper file?
- (NSString *)stringFromTimeInterval:(NSNumber *)interval {
    NSInteger ti = [interval integerValue];
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"Total time: %02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
}

-(void)onSave
{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Saved"];
    [av speakUtterance:utterance];
}

-(void)onDiscard
{
    // TODO: discard workout here
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Discarded"];
    [av speakUtterance:utterance];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveSegue"])
    {
        [self onSave];
    } else if ([segue.identifier isEqualToString:@"discardSegue"]) {
        [self onDiscard];
    }
}

// Text for the spoken time Elapsed
- (NSString *)getSpokenTime:(NSNumber *)interval
{
    int timeElapsed = [interval intValue];
    int mins = (int) (timeElapsed / 60.0);
    int secs = (int) (timeElapsed - mins * 60);
    
    NSString *minuteText;
    if (mins <= 1) {
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
    
    return [NSString stringWithFormat: @"Total Time: %u %s and %02u %s", mins, minuteChars, secs, secondChars];
}
@end

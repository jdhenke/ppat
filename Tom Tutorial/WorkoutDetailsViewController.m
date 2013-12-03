//
//  WorkoutDetailsViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/20/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutDetailsViewController.h"
#import "Workout.h"
#import "SpeakableTime.h"

@interface WorkoutDetailsViewController ()

@end

@implementation WorkoutDetailsViewController

@synthesize dateLabel = _dateLabel;
@synthesize totalTimeLabel = _totalTimeLabel;
@synthesize avgHeartRateLabel = _avgHeartRateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initialSetup
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"MM/dd/yy"];
    NSString *stringFromDate = [formatter stringFromDate:self.selectedWorkout.date];
    self.dateLabel.text = [NSString stringWithFormat: @"Date: %@", stringFromDate];
    self.totalTimeLabel.text = [NSString stringWithFormat: @"Time: %@", [self.selectedWorkout getDisplayTime]];
    
    // Voiceover correct time format
    SpeakableTime *spokenTime = [[SpeakableTime alloc] initWithTime:[self.selectedWorkout.totalTime doubleValue]];
    self.totalTimeLabel.accessibilityLabel = [NSString stringWithFormat: @"Time: %@", [spokenTime getSpokenTimeString]];
    
    // VoiceOver for the Date says it in the full format.
    [formatter setDateStyle:NSDateFormatterLongStyle];
    NSString *dateLabel =[formatter stringFromDate:self.selectedWorkout.date];
    NSLog(@"%@", dateLabel);
    self.dateLabel.accessibilityLabel = [NSString stringWithFormat: @"Date: %@", dateLabel];
    
    self.avgHeartRateLabel.text = [NSString stringWithFormat:@"Average heart rate: %@ bpm", self.selectedWorkout.avgHeartRate];
    self.avgHeartRateLabel.accessibilityLabel= [NSString stringWithFormat:@"Average heart rate: %@ bpm", self.selectedWorkout.avgHeartRate];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initialSetup];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

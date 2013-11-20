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
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self onSave];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO: put this in a helper file?
- (NSString *)stringFromTimeInterval:(NSNumber *)interval {
    NSInteger ti = [interval integerValue];
    NSLog(@"ti: %ld", (long)ti);
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"Total time: %02i:%02i:%02i", hours, minutes, seconds];
}

-(void)onSave
{
    NSLog(@"Testing....");
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Saved"];
    [av speakUtterance:utterance];
}

-(void)saveWorkout
{
    // add notes?
    
}

@end

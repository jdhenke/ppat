//
//  WorkoutPauseViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/11/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutPauseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WorkoutPauseViewController ()

@end

@implementation WorkoutPauseViewController

@synthesize delegate;

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
    AVSpeechUtterance *timeUtterance = [[AVSpeechUtterance alloc]initWithString:@"Time Elapsed: 0 minutes and 30 seconds"];
    [av speakUtterance:timeUtterance];
    AVSpeechUtterance *HRUtterance = [[AVSpeechUtterance alloc]initWithString:@"Heart Rate: 0 beats per minute"];
    [av speakUtterance:HRUtterance];
}

@end

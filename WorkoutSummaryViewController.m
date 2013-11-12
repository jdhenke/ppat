//
//  WorkoutSummaryViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/12/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutSummaryViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface WorkoutSummaryViewController ()

@end

@implementation WorkoutSummaryViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSave:(id)sender
{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Saved"];
    [av speakUtterance:utterance];
}

@end

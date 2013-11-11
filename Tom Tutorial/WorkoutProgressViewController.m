//
//  WorkoutProgressViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutProgressViewController.h"

@interface WorkoutProgressViewController ()

@end

@implementation WorkoutProgressViewController

@synthesize clock;

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
    
    clock.text = @"Time Elapsed: 00:00";
    startTime = [NSDate timeIntervalSinceReferenceDate];
    running = true;
    
    [self updateTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime
{
    if (running == false) return;
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    elapsed = currentTime - startTime; // is it bad to store this in memory every time?
    
    int mins = (int) (elapsed / 60.0);
    int secs = (int) (elapsed - mins * 60);
    
    clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%02u", mins, secs];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}

- (void)pauseWorkout
{
    running = false;
}

@end

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
    
    lastElapsed = 0;
    clock.text = @"Time Elapsed: 00:00";
    [self startClock];

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
    
    clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%02u", mins, secs];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
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

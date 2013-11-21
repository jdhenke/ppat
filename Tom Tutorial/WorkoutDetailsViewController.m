//
//  WorkoutDetailsViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/20/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutDetailsViewController.h"
#import "WorkoutDetails.h"
#import "Workout.h"
#import "SpeakableTime.h"

@interface WorkoutDetailsViewController ()

@end

@implementation WorkoutDetailsViewController

@synthesize dateLabel = _dateLabel;
@synthesize totalTimeLabel = _totalTimeLabel;


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
    self.dateLabel.text = stringFromDate;
    self.totalTimeLabel.text = [self.selectedWorkout getDisplayTime];
    
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

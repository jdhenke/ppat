//
//  WorkoutPauseViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/11/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutPauseViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resume:(id)sender
{
	[self.delegate workoutPauseViewControllerDidResume:self];
}

@end

//
//  SelectDateViewController.m
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/26/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "SelectDateViewController.h"
#import "WorkoutListViewController.h"

@interface SelectDateViewController ()

@end

@implementation SelectDateViewController

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

- (IBAction)next:(id)sender {
    [self performSegueWithIdentifier:@"Next" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Next"])
    {

//        UINavigationController *navigationController = segue.destinationViewController;
WorkoutListViewController *workoutListViewController = (WorkoutListViewController *)segue.destinationViewController;
    workoutListViewController.date = [_datePicker date];
    }
}

@end

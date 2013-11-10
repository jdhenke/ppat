//
//  AudioIntervalTimeViewController.m
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "AudioIntervalTimeViewController.h"

@interface AudioIntervalTimeViewController ()

@end

@implementation AudioIntervalTimeViewController

@synthesize timeIntervals;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.timeIntervals = [[NSArray alloc] initWithObjects:
                         @"No time", @"30 seconds", @"1 minute",@"2 minutes", @"5 minutes",
                         @"10 minutes",@"15 minutes", @"30 minutes",@"1 hour", @"2 hours",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [timeIntervals objectAtIndex:row];
}

@end
    
//
//  AudioIntervalDistanceViewController.m
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "AudioIntervalDistanceViewController.h"

@interface AudioIntervalDistanceViewController ()

@end

@implementation AudioIntervalDistanceViewController

@synthesize distanceIntervals;

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
    self.distanceIntervals = [[NSArray alloc] initWithObjects:
                          @"No distance", @"0.25 miles", @"0.5 miles",@"1 mile", @"2 miles",nil];
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
    return [distanceIntervals count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [distanceIntervals objectAtIndex:row];
}



@end

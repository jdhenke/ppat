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

NSDictionary *timeIntervalDict;

@implementation AudioIntervalTimeViewController

@synthesize timeIntervals;
@synthesize timePicker;

+ (void) initialize
{
    if (!timeIntervalDict)
    {

        timeIntervalDict = @{
                             @"No time": @0,
                             @"30 seconds": @30,
                             @"1 minute": @60,
                             @"2 minutes": @120,
                             @"5 minutes": @300,
                             @"10 minutes": @600,
                             @"15 minutes": @900,
                             @"30 minutes": @1800,
                             @"1 hour": @3600,
                             @"2 hours": @7200
                            };

    }
}

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
    return [timeIntervals count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [timeIntervals objectAtIndex:row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = segue.destinationViewController;
    WorkoutProgressViewController *workoutProgressViewController = [[navigationController viewControllers] objectAtIndex:0];
    NSInteger selectedRow = [timePicker selectedRowInComponent:0];
    NSString *selectedTime = [timeIntervals objectAtIndex:selectedRow];
    workoutProgressViewController.timeIntervalReading = [[timeIntervalDict valueForKey:selectedTime] integerValue];
}

@end
    
//
//  MetricSelectorViewController.m
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/12/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "MetricSelectorViewController.h"
#import "WorkoutAveragesTableViewController.h"
#import "WorkoutListViewController.h"

@interface MetricSelectorViewController ()

@end

NSDictionary *metricNames;

@implementation MetricSelectorViewController

@synthesize metrics;
@synthesize metricPicker;

+ (void) initialize
{
    if (!metricNames)
    {
        metricNames = @{
                        @"Time": @"totalTime",
                        @"Heartrate": @"avgHeartRate"
                        };
    }
}

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
    self.metrics = [[NSArray alloc] initWithObjects:
                          @"Time", @"Heartrate", nil];
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
    return [metrics count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [metrics objectAtIndex:row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toMetricAverages"])
    {
        
        //        UINavigationController *navigationController = segue.destinationViewController;
        WorkoutAveragesTableViewController *next = (WorkoutAveragesTableViewController *)segue.destinationViewController;
        int thing = [metricPicker selectedRowInComponent:0];
        next.metric = [metrics objectAtIndex:thing];
//        int row = [_metricPicker ];
//        NSString* wasup = [_metricPicker objectAtIndex:row];
//        next.metric = [_metricPicker ]
////        next.metric = [_metricPicker s];
    } else if ([segue.identifier isEqualToString:@"toMetricBrowse"])
    {
        WorkoutListViewController *next = (WorkoutListViewController *)segue.destinationViewController;
        int thing = [metricPicker selectedRowInComponent:0];
        NSLog(@"picker item selected: %d", thing);
        NSString *metricName = [metrics objectAtIndex:thing];
        NSLog(@"sending metric...%@", [metricNames valueForKey:metricName]);
        next.metric = [metricNames valueForKey:metricName];
    }
}



@end

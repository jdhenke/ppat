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

@synthesize countryNames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.countryNames = [[NSArray alloc] initWithObjects:
                             @"Australia (AUD)", @"China (CNY)", @"France (EUR)",
                             @"Great Britain (GBP)", @"Japan (JPY)", nil];

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

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return @"Joe";
//    return [countryNames objectAtIndex:row];
}

@end
    
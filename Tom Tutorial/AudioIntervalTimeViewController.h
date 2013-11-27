//
//  AudioIntervalTimeViewController.h
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutProgressViewController.h"

@interface AudioIntervalTimeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *timeIntervals;
}

@property (strong, nonatomic) NSArray *timeIntervals;
@property (strong, nonatomic) IBOutlet UIPickerView *timePicker;
@end

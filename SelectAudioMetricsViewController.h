//
//  SelectAudioMetricsViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/30/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutSettings.h"
#import "AudioIntervalTimeViewController.h"

@interface SelectAudioMetricsViewController : UITableViewController

@property (nonatomic, strong) WorkoutSettings *workoutSettings;

@property (nonatomic, weak) IBOutlet UISwitch *timeOn;
@property (nonatomic, weak) IBOutlet UISwitch *heartRateOn;

@end

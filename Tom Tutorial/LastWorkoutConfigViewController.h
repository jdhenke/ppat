//
//  LastWorkoutConfigViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 12/1/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutSettings.h"

@interface LastWorkoutConfigViewController : UIViewController

@property (weak, nonatomic) WorkoutSettings *workoutSettings;
@property (weak, nonatomic) IBOutlet UILabel *audioMetrics;
@property (weak, nonatomic) IBOutlet UILabel *audioTimeInterval;
@end

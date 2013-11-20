//
//  WorkoutProgressViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutSummaryViewController.h"

@class WorkoutProgressViewController;

@interface WorkoutProgressViewController : UIViewController
{
    NSTimeInterval startTime;
    NSTimeInterval lastElapsed;
    bool running;
    int timeIntervalReading;
}

@property (weak, nonatomic) IBOutlet UILabel *clock;
@property (weak, nonatomic) IBOutlet UILabel *heartRate;
@property (weak, nonatomic) IBOutlet UIButton *pauseResumeButton;

- (IBAction)pauseOrResumeWorkout:(id)sender;
- (IBAction)endWorkout:(id)sender;


@end

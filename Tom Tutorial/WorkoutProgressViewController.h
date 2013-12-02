//
//  WorkoutProgressViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutSummaryViewController.h"
#import "WorkoutSettings.h"
#import  <WFConnector/WFConnector.h>

@class WorkoutProgressViewController;

@interface WorkoutProgressViewController : UIViewController <UIAlertViewDelegate>
{
    NSTimeInterval startTime;
    NSTimeInterval lastElapsed;
    bool running;
    WFHeartrateData* heartRateData;
    NSInteger totalBeatsOverTime;
    NSInteger averageHeartRate;
    NSInteger numTimeSampleHR;
}

@property (nonatomic, weak) WorkoutSettings *workoutSettings;
@property (nonatomic) NSInteger timeIntervalReading;
@property (weak, nonatomic) IBOutlet UILabel *clock;
@property (weak, nonatomic) IBOutlet UILabel *heartRate;
@property (weak, nonatomic) IBOutlet UIButton *pauseResumeButton;
@property (weak, nonatomic) id savedSender;

- (IBAction)pauseOrResumeWorkout:(id)sender;
- (IBAction)endWorkout:(id)sender;


@end

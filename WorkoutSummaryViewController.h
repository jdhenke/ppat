//
//  WorkoutSummaryViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/12/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface WorkoutSummaryViewController : UIViewController <UIAlertViewDelegate>

@property(nonatomic, retain) Workout *workout;

@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UILabel *heartRate;
@property (weak, nonatomic) IBOutlet UILabel *caloriesBurned;
@property (weak, nonatomic) id savedSender;

- (IBAction)deleteWorkout:(id)sender;

@end

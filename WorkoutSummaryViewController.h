//
//  WorkoutSummaryViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/12/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface WorkoutSummaryViewController : UIViewController

@property(nonatomic, retain) Workout *workout;

@property (weak, nonatomic) IBOutlet UILabel *totalTime;

@end

//
//  WorkoutDetailsViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/20/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface WorkoutDetailsViewController : UIViewController {
    UILabel *_dateLabel;
    UILabel *_totalTimeLabel;
}

@property (nonatomic, strong) Workout *selectedWorkout;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *avgHeartRateLabel;
@end

//
//  WorkoutListViewController.h
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/20/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreviousWorkoutCell.h"

@interface WorkoutListViewController : UITableViewController

@property (nonatomic, strong) NSArray *workouts;

@end

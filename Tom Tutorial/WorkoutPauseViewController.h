//
//  WorkoutPauseViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/11/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkoutPauseViewController;

@protocol WorkoutPauseViewControllerDelegate <NSObject>
- (void)workoutPauseViewControllerDidResume:
(WorkoutPauseViewController *)controller;
@end

@interface WorkoutPauseViewController : UIViewController

@property (nonatomic, weak) id <WorkoutPauseViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIButton *resumeButton;

- (IBAction)resume:(id)sender;

@end

//
//  WorkoutProgressViewController.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutProgressViewController : UIViewController
{
    NSTimeInterval startTime;
    NSInteger elapsed;
    bool running;
}

@property (weak, nonatomic) IBOutlet UILabel *clock;
@property (weak, nonatomic) IBOutlet UIButton *pauseOrEndButton;

@end

//
//  AudioIntervalDistanceViewController.h
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioIntervalDistanceViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *distanceIntervals;
}
@property (strong, nonatomic) NSArray *distanceIntervals;
@end

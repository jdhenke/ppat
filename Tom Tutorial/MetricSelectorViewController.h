//
//  MetricSelectorViewController.h
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/12/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetricSelectorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *metrics;
}
@property (weak, nonatomic) IBOutlet UIPickerView *metricPicker;
@property (strong, nonatomic) NSArray *metrics;

@end

//
//  AudioIntervalTimeViewController.h
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioIntervalTimeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray            *countryNames;
}
@property (strong, nonatomic) NSArray *countryNames;
@end

//
//  WorkoutSettings.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/30/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WorkoutSettings : NSManagedObject

@property (nonatomic) BOOL heartRateAudioOn;
@property (nonatomic) NSInteger timeAudioInterval;
@property (nonatomic) BOOL timeAudioOn;

- (NSString *)getAudioMetrics;
- (NSString *)getTimeIntervalText;
@end

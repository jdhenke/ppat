//
//  WorkoutSettings.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/30/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutSettings.h"


@implementation WorkoutSettings

@dynamic heartRateAudioOn;
@dynamic timeAudioInterval;
@dynamic timeAudioOn;

- (NSString *)getAudioMetrics
{
    NSMutableArray *audioMetrics = [[NSMutableArray alloc] init];
    if (self.timeAudioOn) {
        [audioMetrics addObject:@"time elapsed"];
    }
    if (self.heartRateAudioOn) {
        [audioMetrics addObject:@"heart rate"];
    }
//    NSLog(@"audio metrics string: %@", [audioMetrics componentsJoinedByString:@", "]);
    if ([audioMetrics count] > 0) {
        return [audioMetrics componentsJoinedByString:@", "];
    }
    else {
        return @"None";
    }
}

- (NSString *)getTimeIntervalText
{
    NSDictionary *timeToText = @{
                                 [NSNumber numberWithInt:0]: @"No time",
                                 [NSNumber numberWithInt:30]: @"30 seconds",
                                 [NSNumber numberWithInt:60]: @"1 minute",
                                 [NSNumber numberWithInt:120]: @"2 minutes",
                                 [NSNumber numberWithInt:300]: @"5 minutes",
                                 [NSNumber numberWithInt:600]: @"10 minutes",
                                 [NSNumber numberWithInt:900]: @"15 minutes",
                                 [NSNumber numberWithInt:1800]: @"30 minutes",
                                 [NSNumber numberWithInt:3600]: @"1 hour",
                                 [NSNumber numberWithInt:7200]: @"2 hours"
                                 };
    NSLog(@"time audio interval: %d", self.timeAudioInterval);
    NSLog(@"time to text: %@", [timeToText objectForKey:[NSNumber numberWithInteger:self.timeAudioInterval]]);
    return [timeToText objectForKey:[NSNumber numberWithInteger:self.timeAudioInterval]];
}

@end

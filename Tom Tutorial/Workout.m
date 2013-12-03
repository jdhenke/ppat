//
//  Workout.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "Workout.h"
#import "SpeakableTime.h"

//@interface Workout (PrimitiveAccessors)
//@property (nonatomic) NSNumber *primitiveTime;
//@end

@implementation Workout

@dynamic date;
@dynamic avgHeartRate;
@dynamic totalTime;
@dynamic note;
@dynamic distance;

//- (NSTimeInterval *)totalTime
//{
//    // custom accessor?
//}

//- (double)totalTime
//{
//    [self willAccessValueForKey:@"totalTime"];
//    NSNumber *tmpValue = [self primitiveTime];
//    [self didAccessValueForKey:@"totalTime"];
//    return (tmpValue!=nil) ? [tmpValue doubleValue] : 0.0; // Or a suitable representation for nil.
//}
//
//- (void)setTotalTime:(double)value
//{    
//    NSNumber *temp = @(value);
//    [self willChangeValueForKey:@"totalTime"];
//    [self setPrimitiveTime:temp];
//    [self didChangeValueForKey:@"totalTime"];
//}

//TODO: Does Apple have soem built-in way to differentiate text/accessibility label for each attribute?

- (NSString *)getDisplayTime
{
    NSInteger ti = [self.totalTime integerValue];
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
}

- (NSString *)getSpokenTime
{
    SpeakableTime *spokenTime = [[SpeakableTime alloc] initWithTime:[self.totalTime doubleValue]];
    return [spokenTime getSpokenTimeString];
}

- (NSString *)getDisplayHR
{
    return [NSString stringWithFormat:@"%@ bpm", self.avgHeartRate];
}

- (NSString *)getSpokenHR
{
    return [NSString stringWithFormat:@"%@ beats per minute", self.avgHeartRate];
}

- (NSInteger)getMinutes
{
    NSInteger ti = [self.totalTime integerValue];
    return (ti / 60) % 60;
}

- (NSInteger)getHRValue
{
    return [self.avgHeartRate intValue];
}

@end

//
//  Workout.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "Workout.h"

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


@end

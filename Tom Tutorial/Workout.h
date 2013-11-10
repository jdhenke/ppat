//
//  Workout.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Workout : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * avgHeartRate;
@property (nonatomic, retain) NSNumber * totalTime;
@property (nonatomic, retain) UNKNOWN_TYPE note;
@property (nonatomic, retain) UNKNOWN_TYPE distance;

@end

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
@property (nonatomic, retain) NSNumber * avgHeartRate;
@property (nonatomic) NSNumber * totalTime;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSDecimalNumber * distance;

- (NSString *) getDisplayTime;

@end

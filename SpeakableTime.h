//
//  SpeakableTime.h
//  Tom Tutorial
//
//  Created by Jen Liu on 11/20/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SpeakableTime : NSObject

@property (nonatomic) NSTimeInterval time;

- (NSString *)getSpokenTimeString;
- (NSString *)getDisplayTimeString;
- (void)speakTime;
- (id)initWithTime:(NSTimeInterval)time;

@end
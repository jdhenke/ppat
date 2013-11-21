//
//  SpeakableTime.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/20/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "SpeakableTime.h"
#import <AVFoundation/AVFoundation.h>

@implementation SpeakableTime

@synthesize time;

- (id)initWithTime:(NSTimeInterval)timeInterval
{
    self.time = timeInterval;
    return self;
}

- (NSString *)getSpokenTimeString
{
    int mins = (int) (time / 60.0);
    int secs = (int) (time - mins * 60);
    
    NSString *minuteText;
    if (mins == 1) {
        minuteText = [NSString stringWithFormat: @"minute"];
    } else {
        minuteText = [NSString stringWithFormat: @"minutes"];
    }
    
    NSString *secondText;
    if (secs == 1) {
        secondText = [NSString stringWithFormat: @"second"];
    } else {
        secondText = [NSString stringWithFormat: @"seconds"];
    }
    
    const char *minuteChars = [minuteText UTF8String];
    const char *secondChars = [secondText UTF8String];
    
    return [NSString stringWithFormat: @"%u %s and %02u %s", mins, minuteChars, secs, secondChars];
}

- (void)speakTime
{
    // wait for voiceover to shut up
    while ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
        // do nothing
    }
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *timeUtterance = [[AVSpeechUtterance alloc]initWithString:[self getSpokenTimeString]];
    [av speakUtterance:timeUtterance];
}

- (NSString *)getDisplayTimeString
{
    NSInteger ti = time;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
}

@end

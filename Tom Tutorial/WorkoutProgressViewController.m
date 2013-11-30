//
//  WorkoutProgressViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/10/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutProgressViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <math.h>
#import "AppDelegate.h"
#import "Workout.h"

@interface WorkoutProgressViewController ()

@end

@implementation WorkoutProgressViewController

@synthesize clock, heartRate, pauseResumeButton, savedSender;
@synthesize heartrateConnection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        applicableNetworks = WF_NETWORKTYPE_BTLE | WF_NETWORKTYPE_ANTPLUS;
        sensorType = WF_SENSORTYPE_HEARTRATE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    // wait for voiceover to shut up
//    while ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
//        // do nothing
//    }
    
    // Announce that the workout has started.
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Started"];
    [av speakUtterance:utterance];

    
    // Update the clock.
    lastElapsed = 0;
    clock.text = @"Time Elapsed: 0 seconds";
    clock.accessibilityLabel = clock.text;
    
    // Update the heart rate.
    heartRate.text = @"Heart rate monitor not connected.";
    heartRate.accessibilityLabel = heartRate.text;
    [self startClock];
    
    self.pauseResumeButton.accessibilityLabel = @"Pause";
}

-(void) viewDidAppear:(BOOL)animated
{
    if ( hardwareConnector.isCommunicationHWReady )
    {
        [self updateSensorStatus];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTime
{
    if (running == false) return;

    NSTimeInterval elapsed = [self getTotalTimeElapsed];

    int mins = (int) (elapsed / 60.0);
    int secs = (int) (elapsed - mins * 60);
    int hours = (int) mins / 60;
    
    if (hours == 0) {
        clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%02u", mins, secs];
    } else {
        mins %= 60;
        clock.text = [NSString stringWithFormat: @"Time Elapsed: %u:%u:%02u", hours, mins, secs];
    }

    clock.accessibilityLabel = [self getSpokenTime:elapsed];
    
    // If the time is at the time interval specified, read the interval information out loud.
    if (self.timeIntervalReading > 0 && (int)elapsed%self.timeIntervalReading ==0 && secs > 5) {
        [self readIntervalWithTime:elapsed];
    }
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
    
    [self updateHeartRate];
}

- (NSString *)getSpokenTime:(NSTimeInterval)elapsed
{
    int mins = (int) (elapsed / 60.0);
    int secs = (int) (elapsed - mins * 60);
    
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
    
    return [NSString stringWithFormat: @"Time Elapsed: %u %s and %02u %s", mins, minuteChars, secs, secondChars];
}

- (void)readIntervalWithTime:(NSTimeInterval)elapsed
{
    
    // wait for voiceover to shut up
    while ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
        // do nothing
    }
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *timeUtterance = [[AVSpeechUtterance alloc]initWithString:[self getSpokenTime:elapsed]];
    [av speakUtterance:timeUtterance];
    AVSpeechUtterance *HRUtterance = [[AVSpeechUtterance alloc]initWithString:heartRate.text];
    [av speakUtterance:HRUtterance];
}

- (NSTimeInterval)getTotalTimeElapsed
{
    if (running) {
        NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
        return lastElapsed + currentTime - startTime;
    } else {
        return lastElapsed;
    }
}

- (void)pauseWorkout
{
    [self pauseClock];
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Pausing Workout"];
    [av speakUtterance:utterance];
}

- (void)pauseClock
{
    lastElapsed = [self getTotalTimeElapsed];
    running = false;
}

- (void)startClock
{
    running = true;
    startTime = [NSDate timeIntervalSinceReferenceDate];

    [self updateTime];

}

- (void)resumeWorkout
{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Resuming Workout"];
    [av speakUtterance:utterance];
	[self startClock];
}

- (IBAction)pauseOrResumeWorkout:(id)sender
{
    if (running) {
        [self pauseWorkout];
        [self.pauseResumeButton setTitle:@"Resume Workout" forState:UIControlStateNormal];
        self.pauseResumeButton.accessibilityLabel = @"Resume Workout";
    } else {
        [self resumeWorkout];
        [self.pauseResumeButton setTitle:@"Pause Workout" forState:UIControlStateNormal];
        self.pauseResumeButton.accessibilityLabel = @"Pause Workout";
    }
}

- (IBAction)endWorkout:(id)sender
{
    [self pauseClock];
    self.savedSender = sender;
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"End Workout Confirmation"
                                                      message:@"Do you want to end this workout?"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Definitely End Workout", nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
        AVSpeechUtterance *endUtterance = [[AVSpeechUtterance alloc]initWithString:@"Ending Workout"];
        [av speakUtterance:endUtterance];
        [self performSegueWithIdentifier:@"EndWorkout" sender:self.savedSender];
    } else {
        [self resumeWorkout];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EndWorkout"])
    {
        // TODO: should it be embedded in NavigationController so it's a modal?
        UINavigationController *navigationController = segue.destinationViewController;
        WorkoutSummaryViewController *workoutSummaryViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        // pass the workout into next controller
//        WorkoutSummaryViewController *workoutSummaryViewController = (WorkoutSummaryViewController *)segue.destinationViewController;
        workoutSummaryViewController.workout = [self createWorkout];
    }
}

-(Workout *)createWorkout
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    NSManagedObject *workout = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
    NSNumber *totalTime = [NSNumber numberWithDouble:[self getTotalTimeElapsed]];
    
    [workout setValue:totalTime forKey:@"totalTime"];
    [workout setValue:[NSDate date] forKey:@"date"];
    NSError *error = nil;
    
	if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    return (Workout *)workout;
}

// Wahoo HR monitor
- (void)updateHeartRate {
    [self updateData];
    
    WFHeartrateData* hrData = [self.heartrateConnection getHeartrateData];
    NSLog(@"%d", [self.heartrateConnection hasData]);
	//WFHeartrateRawData* hrRawData = [self.heartrateConnection getHeartrateRawData];
	if ( hrData != nil )
	{
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:hrData.computedHeartrate];
        
        // unformatted value.
		// computedHeartrateLabel.text = [NSString stringWithFormat:@"%d", hrData.computedHeartrate];
        
        // update basic data.
        heartRate.text = [hrData formattedHeartrate:TRUE];
		//beatTimeLabel.text = [NSString stringWithFormat:@"%d", hrData.beatTime];
		
        // update raw data.
		//beatCountLabel.text = [NSString stringWithFormat:@"%d", hrRawData.beatCount];
		//previousBeatLabel.text = [NSString stringWithFormat:@"%d", hrRawData.previousBeatTime];
        
        // BTLE HR monitors optionally transmit R-R intervals.  this demo does not
        // display R-R values.  however, the following code is included to demonstrate
        // how to read and parse R-R intervals.
        if ( [hrData isKindOfClass:[WFBTLEHeartrateData class]] )
        {
            NSArray* rrIntervals = [(WFBTLEHeartrateData*)hrData rrIntervals];
            for ( NSNumber* rr in rrIntervals )
            {
                NSLog(@"R-R Interval: %1.3f s.", [rr doubleValue]);
            }
        }
        
	}
	else
	{
        heartRate.text = @"Heart rate monitor is unavailable";
	}
    
}

//--------------------------------------------------------------------------------
- (void)onSensorConnected:(WFSensorConnection*)connectionInfo
{
    WFHeartrateConnection* hrc = self.heartrateConnection;
    if ( hrc )
    {
       // hrc.delegate = self;
    }
}


//--------------------------------------------------------------------------------
- (WFHeartrateConnection*)heartrateConnection
{
	WFHeartrateConnection* retVal = nil;
    NSLog(@"Sensor connection: %@", self.sensorConnection);
	if ( [self.sensorConnection isKindOfClass:[WFHeartrateConnection class]] )
	{
		retVal = (WFHeartrateConnection*)self.sensorConnection;
	}
	
	return retVal;
}

- (IBAction)searchClicked:(id)sender
{
//    // configure and display the sensor manager view.
//	SensorManagerViewController* vc = [[SensorManagerViewController alloc] initWithNibName:@"SensorManagerViewController" bundle:nil];
//	[vc configForSensorType:sensorType onNetworks:applicableNetworks];
    
    // get the current connection status.
	WFSensorConnectionStatus_t connState = WF_SENSOR_CONNECTION_STATUS_IDLE;
	if ( sensorConnection != nil )
	{
		connState = sensorConnection.connectionStatus;
	}
	
	// set the button state based on the connection state.
	switch (connState)
	{
		case WF_SENSOR_CONNECTION_STATUS_IDLE:
		{
			// create the connection params.
			WFConnectionParams* params = nil;
			//
			// if wildcard search is specified, create empty connection params.
			if ( wildcardSwitch.on )
			{
				params = [[WFConnectionParams alloc] init];
				params.sensorType = sensorType;
			}
			//
			// otherwise, get the params from the stored settings.
			else
			{
				params = [hardwareConnector.settings connectionParamsForSensorType:sensorType];
			}
			
			if ( params != nil)
			{
                // set the search timeout.
                params.searchTimeout = hardwareConnector.settings.searchTimeout;
                
                // if the connection request is a wildcard, use proximity search.
                if ( params.isWildcard )
                {
                    // proximity pairing is available only in the AP2 version of
                    // the Wahoo fisica hardware.  the proximity search facilitates
                    // pairing an unknown device when more than one of the device
                    // type are present.  the range WF_PROXIMITY_RANGE_1 is the
                    // closest - meaning the device must be very close to the
                    // fisica key in order to connect.  ranges are relative 1-10.
                    //
                    // NOTE:  if the fisica hardware is the AP1 version, the API
                    // will issue a standard connection request.  this case is the
                    // same as invoking requestSensorConnection:.
                    //
                    // use proximity search.
                    if ( proximitySwitch.on )
                    {
                        self.sensorConnection = [hardwareConnector requestSensorConnection:params withProximity:WF_PROXIMITY_RANGE_2];
                    }
                    //
                    // use normal search.
                    else
                    {
                        self.sensorConnection = [hardwareConnector requestSensorConnection:params];
                    }
                }
                // otherwise, use normal connection request.
                else
                {
                    self.sensorConnection = [hardwareConnector requestSensorConnection:params];
                }
                
                // set delegate to receive connection status changes.
                self.sensorConnection.delegate = self;
			}
			break;
		}
			
		case WF_SENSOR_CONNECTION_STATUS_CONNECTING:
		case WF_SENSOR_CONNECTION_STATUS_CONNECTED:
			// disconnect the sensor.
			[self.sensorConnection disconnect];
			break;
			
		case WF_SENSOR_CONNECTION_STATUS_DISCONNECTING:
        case WF_SENSOR_CONNECTION_STATUS_INTERRUPTED:
			// do nothing.
			break;
	}
	
	//[self checkState];

}

- (void)updateSensorStatus
{
	// configure the status fields for the heartrate sensor.
	NSArray* connections = [hardwareConnector getSensorConnections:WF_SENSORTYPE_HEARTRATE];
	WFSensorConnection* sensor = ([connections count]>0) ? (WFSensorConnection*)[connections objectAtIndex:0] : nil;
    if ( sensor )
    {
        BOOL conn = (sensor != nil && sensor.isConnected) ? TRUE : FALSE;
        USHORT devId = sensor.deviceNumber;
        NSLog(@"%d", conn);
        NSLog(@"Device id:%d", devId);
    }
}





@end

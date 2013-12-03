//
//  WorkoutSummaryViewController.m
//  Tom Tutorial
//
//  Created by Jen Liu on 11/12/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutSummaryViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Workout.h"
#import "AppDelegate.h"
#import "SpeakableTime.h"

@interface WorkoutSummaryViewController ()

@end

@implementation WorkoutSummaryViewController

@synthesize workout, savedSender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"workout time: %@", self.workout.totalTime);
    self.totalTime.text = [NSString stringWithFormat: @"Total time: %@", [self.workout getDisplayTime]];
    self.totalTime.accessibilityLabel = [self.workout getSpokenTime];
    
    // Accounts for when the heart rate monitor did not calculate an average heart rate.
    NSString *heartRateText = @"Heart rate monitor was not connected.";
    
    if (self.workout.avgHeartRate > 0) {
        heartRateText = [NSString stringWithFormat: @"Average Heart Rate: %@", [self.workout getDisplayHR]];
    }
    self.heartRate.text = heartRateText;
    self.heartRate.accessibilityLabel = heartRateText;
    
    // Accounts for when the settings have not been set for the person and no heart rate has been calculated.
    NSString *calorieText = @"";
    
    /* Male->  Calories Burned = [(Age x 0.2017) + (Weight x 0.09036) + (Heart Rate x 0.6309) -- 55.0969] x Time / 4.184.
       Female-> Calories Burned = [(Age x 0.074) -- (Weight x 0.05741) + (Heart Rate x 0.4472) -- 20.4022] x Time / 4.184.
     */
    
    // Set the values to Jonathan's attribute.
    NSInteger age = 58;
    NSString *gender = @"Male";
    NSInteger weight = 156;
    double calculatedCaloriesBurned = 0;
    
    if (self.workout.avgHeartRate > 0 ) {
        if ([gender isEqualToString:@"Male"]) {
            calculatedCaloriesBurned = ((age * 0.2017) + (weight * 0.09036) + ([self.workout getHRValue] * 0.6309) - 55.0969) * [self.workout getMinutes] / 4.184;
        }
        else if ([gender isEqualToString:@"Female"]) {
            calculatedCaloriesBurned = ((age * 0.074) - (weight * 0.05741) + ([self.workout getHRValue] * 0.4472) - 20.4022) * [self.workout getMinutes] / 4.184;
        }
        calorieText = [NSString stringWithFormat:@"Total Calories Burned: %f", calculatedCaloriesBurned];
    }
    
    self.caloriesBurned.text = calorieText;
    self.caloriesBurned.accessibilityLabel = calorieText;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onSave
{
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Saved"];
    [av speakUtterance:utterance];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveSegue"])
    {
        [self onSave];
    }
}

- (IBAction)deleteWorkout:(id)sender
{
    self.savedSender = sender;
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Delete Workout Confirmation"
                                                      message:@"Do you want to delete this workout?"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Definitely Delete Workout",@"Cancel", nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* context = appDelegate.managedObjectContext;
        [context deleteObject:workout];
        
        AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
        AVSpeechUtterance *endUtterance = [[AVSpeechUtterance alloc]initWithString:@"Workout Deleted"];
        [av speakUtterance:endUtterance];
        
        [self performSegueWithIdentifier:@"Home" sender:self.savedSender];
    } else {
        // do nothing
    }
}

@end

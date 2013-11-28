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
    
    SpeakableTime *spokenTime = [[SpeakableTime alloc] initWithTime:[self.workout.totalTime doubleValue]];
    self.totalTime.accessibilityLabel = [NSString stringWithFormat: @"Time: %@", [spokenTime getSpokenTimeString]];
    
    NSString *heartRateText = @"Heart Rate: 120 beats per minute";
    self.heartRate.text = heartRateText;
    self.heartRate.accessibilityLabel = heartRateText;
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
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Definitely Delete Workout", nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
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

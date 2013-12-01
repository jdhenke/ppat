//
//  WorkoutListViewController.m
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/20/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutListViewController.h"
#import "Workout.h"
#import "AppDelegate.h"
#import "WorkoutDetailsViewController.h"

@interface WorkoutListViewController ()

@end

@implementation WorkoutListViewController

@synthesize workouts;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Workout"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // filter date
    if (self.date != NULL) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self.date];
        NSInteger hour = [components hour] + 5; // ACCOUNTING FOR TIME ZONE
        NSInteger minute = [components minute];
        NSInteger second = [components second];

        second = 0;
        int dayOffset = 60 * 60 * 24;
        int randomHourComponentDatePickerTacksOnToItsDate = 60 * 60 * hour;
        int randomMinuteComponentDatePickerTacksOnToItsDate = 60 * minute;
        int randomSecondComponentDatePickerTacksOnToItsDate = second;

        int startDateOffset = 0
            + randomHourComponentDatePickerTacksOnToItsDate
            + randomMinuteComponentDatePickerTacksOnToItsDate
            + randomSecondComponentDatePickerTacksOnToItsDate;

        NSDate *startDate = [self.date dateByAddingTimeInterval:0 - startDateOffset];
        NSDate *endDate = [startDate dateByAddingTimeInterval:dayOffset];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"((date >= %@) AND (date < %@)) || (date = nil)",startDate,endDate];
        [fetchRequest setPredicate:predicate];
    }
    
    // make request
    NSError *error;
    self.workouts = [context executeFetchRequest:fetchRequest error:&error];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.workouts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"workoutTableCell";
    
    PreviousWorkoutCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[PreviousWorkoutCell alloc]
        initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:CellIdentifier];
    }
    
    Workout *workout = [workouts objectAtIndex:[self.workouts count] - 1 - indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"MM/dd/yy HH:mm"];

    NSString *stringFromDate = [formatter stringFromDate:workout.date];
cell.workoutHeader.text = stringFromDate;
    
    // VoiceOver reads the date slightly differently from what is displayed on the screen where it will.
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateLabel =[formatter stringFromDate:workout.date];
    cell.workoutHeader.accessibilityLabel = dateLabel;
    
    if ([self.metric isEqualToString:@"totalTime"]) {
        cell.metricValue.text = [NSString stringWithFormat:@"%@",[workout getDisplayTime]];
        cell.metricValue.accessibilityLabel = [workout getSpokenTime];
    } else if ([self.metric isEqualToString:@"avgHeartRate"]) {
        cell.metricValue.text = [NSString stringWithFormat:@"%@",[workout getDisplayHR]];
        cell.metricValue.accessibilityLabel = [workout getSpokenHR];
    } else {
        cell.metricValue.text = @"";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkoutDetailsViewController* detailController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"WorkoutDetailsViewController"];
    detailController.selectedWorkout = [self.workouts objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}


@end

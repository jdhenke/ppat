//
//  WorkoutAveragesTableViewController.m
//  Tom Tutorial
//
//  Created by Joseph Henke on 11/26/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WorkoutAveragesTableViewController.h"
#import "MetricAverageTableCell.h"
#import "AppDelegate.h"
#import "Workout.h"

@interface WorkoutAveragesTableViewController ()

@end

@implementation WorkoutAveragesTableViewController

int indexToNumDays[] = {7,30,365};
NSString* indexToString[] = {@"1 week", @"1 month", @"1 year"};
NSString* units;

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
//    NSLog(@"%@",self.metric);
    if ([self.metric isEqualToString:@"Time"]) {
        units = @"seconds";
    } else if ([self.metric isEqualToString:@"Heartrate"]){
        units = @"bpm";
    }

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
    return 3;
}

- (int) getAverage: (NSIndexPath*) path {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Workout"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // specify correct workout range
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [endDate dateByAddingTimeInterval:-60*60*24*indexToNumDays[path.row]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"((date >= %@) AND (date < %@)) || (date = nil)",startDate,endDate];
    [fetchRequest setPredicate:predicate];
    
    // make request
    NSError *error;
    NSArray *workouts = [context executeFetchRequest:fetchRequest error:&error];
    
//    printf("%i\n", [workouts count]);

    if ([_metric isEqualToString:@"Time"]) {
        int totalTime = 0;
        int numTimes = 0;
        for (int i = 0; i < [workouts count]; ++i) {
            Workout *workout = [workouts objectAtIndex:i];
            totalTime += [workout.totalTime intValue];
            numTimes += 1;
        }
        if (numTimes > 0) {
            return totalTime / numTimes;
        } else {
            return 0;
        }
    } else if ([_metric isEqualToString:@"Heartrate"]) {
        int totalHeartRate = 0;
        int numTimes = 0;
        for (int i = 0; i < [workouts count]; ++i) {
            Workout *workout = [workouts objectAtIndex:i];
            totalHeartRate += [workout.avgHeartRate intValue];
            numTimes += 1;
        }
        if (numTimes > 0) {
            return totalHeartRate / numTimes;
        } else {
            return 0;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MetricAverageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // create timeframe text
    NSString* text = indexToString[(int)indexPath.row];
    
    // create timeframe average
    int average = [self getAverage:indexPath];
    
    // actually assign it to the cell
    cell.label.text = [NSString stringWithFormat:@"%@ %i %@", text, average, units];
    return cell;
}

@end

///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2013 Wahoo Fitness. All Rights Reserved.
//
// The information contained herein is property of Wahoo Fitness LLC.
// Terms and conditions of usage are described in detail in the
// WAHOO FITNESS API LICENSE AGREEMENT.
//
// Licensees are granted free, non-transferable use of the information.
// NO WARRANTY of ANY KIND is provided.
// This heading must NOT be removed from the file.
///////////////////////////////////////////////////////////////////////////////
//
//  SensorManagerViewController.h
//  FisicaDemo
//
//  Created by Michael Moore on 11/30/10.
//  Copyright 2010 Wahoo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WFConnector/WFConnector.h>


@protocol SensorManagerDelegate

- (void)requestConnectionToDevice:(WFDeviceParams*)devParams;

@end


@interface SensorManagerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
   // id<SensorManagerDelegate> delegate;
	WFSensorType_t sensorType;
    
    UITableView* pairedTable;
    UISegmentedControl* networkSegment;
    UILabel* sensorTypeLabel;
    UITableView* discoveredTable;
    UIButton* searchButton;
    
	NSArray* deviceParams;
    NSMutableArray* discoveredSensors;
    BOOL isSearching;
    USHORT usAllowedNetworks;
}


@property (nonatomic, assign) id<SensorManagerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UISegmentedControl* networkSegment;
@property (nonatomic, retain) IBOutlet UILabel* sensorTypeLabel;
@property (nonatomic, retain) IBOutlet UITableView* discoveredTable;
@property (nonatomic, retain) IBOutlet UIButton* searchButton;
@property (nonatomic, retain) IBOutlet UITableView* pairedTable;


- (IBAction)searchClicked:(id)sender;


- (void)configForSensorType:(WFSensorType_t)eSensorType onNetworks:(USHORT)usNetworks;

@end

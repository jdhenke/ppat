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
//  BTDeviceInfoVC.h
//  WahooDemo
//
//  Created by Michael Moore on 2/28/12.
//  Copyright (c) 2012 Wahoo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WFConnector/WFConnector.h>


@interface BTDeviceInfoVC : UIViewController
{
    WFBTLECommonData* commonData;
    WFSensorConnection* sensorConnection;
    
    UILabel* deviceNameLabel;
    UILabel* manufacturerNameLabel;
    UILabel* modelNumberLabel;
    UILabel* serialNumberLabel;
    UILabel* hardwareRevLabel;
    UILabel* firmwareRevLabel;
    UILabel* softwareRevLabel;
    UILabel* systemIdLabel;
    UILabel* battLevelLabel;
    UILabel* battPresentLabel;
    UILabel* battDischargeLabel;
    UILabel* battChargeLabel;
    UILabel* battCriticalLabel;
}


@property (nonatomic, retain) WFBTLECommonData* commonData;
@property (nonatomic, retain) WFSensorConnection* sensorConnection;
@property (nonatomic, retain) IBOutlet UILabel* deviceNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* manufacturerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel* modelNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel* serialNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel* hardwareRevLabel;
@property (nonatomic, retain) IBOutlet UILabel* firmwareRevLabel;
@property (nonatomic, retain) IBOutlet UILabel* softwareRevLabel;
@property (nonatomic, retain) IBOutlet UILabel* systemIdLabel;
@property (nonatomic, retain) IBOutlet UILabel* battLevelLabel;
@property (nonatomic, retain) IBOutlet UILabel* battPresentLabel;
@property (nonatomic, retain) IBOutlet UILabel* battDischargeLabel;
@property (nonatomic, retain) IBOutlet UILabel* battChargeLabel;
@property (nonatomic, retain) IBOutlet UILabel* battCriticalLabel;


- (void)updateDisplay;

@end

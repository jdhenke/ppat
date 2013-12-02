//
//  WahooManager.h
//  Tom Tutorial
//
//  Created by UID Group on 12/1/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConnector/WFConnector.h>

@interface WahooManager : NSObject <WFHardwareConnectorDelegate, WFSensorConnectionDelegate>
-(void) launchHeartRate;

@end

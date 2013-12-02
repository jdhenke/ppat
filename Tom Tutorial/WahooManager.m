//
//  WahooManager.m
//  Tom Tutorial
//
//  Created by UID Group on 12/1/13.
//  Copyright (c) 2013 MIT PPAT Team Jonathan. All rights reserved.
//

#import "WahooManager.h"

@implementation WahooManager {
    WFHeartrateConnection* sensorConnection;
}

- (void) launchHeartRate
{
    // Configure the hardware connector.
    WFHardwareConnector* hardwareConnector = [WFHardwareConnector sharedConnector];
    hardwareConnector.delegate = self;
	hardwareConnector.sampleRate = 0.5;  // sample rate 500 ms, or 2 Hz.
    //
    // determine support for BTLE.
    if ( hardwareConnector.hasBTLESupport )
    {
        // enable BTLE.
        [hardwareConnector enableBTLE:TRUE];
    }
    NSLog(@"%@", hardwareConnector.hasBTLESupport?@"DEVICE HAS BTLE SUPPORT":@"DEVICE DOES NOT HAVE BTLE SUPPORT");
    
    // set HW Connector to call hasData only when new data is available.
    [hardwareConnector setSampleTimerDataCheck:YES];
}

#pragma mark -
#pragma mark HardwareConnectorDelegate Implementation

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector connectedSensor:(WFSensorConnection*)connectionInfo
{
    NSLog(@"Sensor connected");
    NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              connectionInfo, @"connectionInfo",
                              nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:WF_NOTIFICATION_SENSOR_CONNECTED object:nil userInfo:userInfo];
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector didDiscoverDevices:(NSSet*)connectionParams searchCompleted:(BOOL)bCompleted
{
    NSLog(@"Discovered devices");
    
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector disconnectedSensor:(WFSensorConnection*)connectionInfo
{
    NSLog(@"disconnected sensor");
}

//--------------------------------------------------------------------------------
- (void)hardwareConnector:(WFHardwareConnector*)hwConnector stateChanged:(WFHardwareConnectorState_t)currentState
{
	BOOL connected = ((currentState & WF_HWCONN_STATE_ACTIVE) || (currentState & WF_HWCONN_STATE_BT40_ENABLED)) ? TRUE : FALSE;
	if (connected)
	{
        NSLog(@"sensor connected- state changed");
        if ( hwConnector.isCommunicationHWReady )
        {
            NSLog(@"connection ready");
            
            // create the connection params.
			WFConnectionParams* params =  [hwConnector.settings connectionParamsForSensorType:WF_SENSORTYPE_HEARTRATE];
			
			if ( params != nil)
			{
                // set the search timeout.
                params.searchTimeout = hwConnector.settings.searchTimeout;
                
                //  use normal connection request.
                sensorConnection = (WFHeartrateConnection*)[hwConnector requestSensorConnection:params];
                
                // set delegate to receive connection status changes.
                sensorConnection.delegate = self;
			}
            
        }
        
	}
	else
	{
        NSLog(@"sensor disconnected- state changed");
	}
}


//--------------------------------------------------------------------------------
- (void)hardwareConnectorHasData
{
    NSLog(@"HAS DATA");
    WFHeartrateData* hrData = [sensorConnection getHeartrateData];
    NSLog(@"%@", [hrData formattedHeartrate:TRUE]);
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:hrData forKey:@"heartRateData"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HeartRate" object:dataDict];
}

#pragma mark -
#pragma mark - WFSensorConnectionDelegate


/**
 * Invoked when the WFSensorConnection fails to connect to a device before
 * the specified timeout period ellapses.
 *
 * @param connectionInfo The WFSensorConnection instance.
 */
- (void)connectionDidTimeout:(WFSensorConnection*)connectionInfo{
    NSLog(@"Connection timed out");
    
}

/**
 * Invoked when the WFSensorConnection has changed connection state.
 *
 * @param connectionInfo The WFSensorConnection instance.
 *
 * @param connState A ::WFSensorConnectionStatus_t value indicating the
 * current connection state.
 */
- (void)connection:(WFSensorConnection*)connectionInfo stateChanged:(WFSensorConnectionStatus_t)connState{
    NSLog(@"Connection has changed states");
}

@end

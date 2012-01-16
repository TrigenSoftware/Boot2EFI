//
//  EFIViewController.m
//
//  Created by Eduard Sionov on 1/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EFIViewController.h"

@implementation EFIViewController
@synthesize methodViewController;
@synthesize installInfo;
@synthesize delegate;
- (void)awakeFromNib {
	installInfo = [[EFIInstallInfo alloc] init];
	diskUtil = [[EFIDiskUtil alloc] init];
	deviceInformationArray = [NSMutableArray array];
	//get device nodes
	NSMutableArray * deviceNodes = [NSMutableArray arrayWithArray:[diskUtil deviceNodes]];
	
	//get devices information array
	for (int i=0; i<[deviceNodes count]; i++) {
		DeviceInformation * devInfo = [[DeviceInformation alloc] init];
		NSString * devNode = [deviceNodes objectAtIndex:i];
		devInfo = [diskUtil deviceInfoWithNode:devNode];
		[deviceInformationArray addObject:devInfo];
	}
	//delete non GUID partition scheme devices from array
	for (int i=0; i<[deviceInformationArray count]; ++i) {
		if ([[deviceInformationArray objectAtIndex:i] deviceType] != GUID_partition_scheme) {
			[deviceInformationArray removeObjectAtIndex:i];
			i=-1;
		}
	}
	//delete all devices if it is not at 0 position
	/*for (int i=[deviceInformationArray count]-1; i>0; i--) {
		if (i > 0) {
			[deviceInformationArray removeObjectAtIndex:i];
		}
	}	*/
	
	//alarm if there is no GUID_partition_scheme devices
	if ([deviceInformationArray count] == 0) {
		[self alarmNoGUID];
	}
	
	//---------------------------------------------------------------------------
	//set info to view elements
	for (int i=0; i<[deviceInformationArray count]; i++) {
		[deviceNamePopUp addItemWithTitle:[[deviceInformationArray objectAtIndex:i] deviceName]];	
	}
    	
	
	//set default install info
	installInfo.deviceNode = [[deviceInformationArray objectAtIndex:0] deviceNode];
	
	//set extra view to method view as default

	[methodView addSubview:methodViewController.optionalViewController.view];
		
	[diskUtil release];
	[deviceInformationArray retain];
	//[installInfo retain];
}

- (IBAction)installPressed:(id)sender {	
	installInfo.bootfile = [methodViewController.optionalViewController.dropBootView getBootDirectory];
	installInfo.extraDir = [methodViewController.optionalViewController.dropExtraView getExtra];
    
    if (installInfo.bootfile != nil && installInfo.extraDir != nil) {
        NSLog(@"--------------------------------------------");	
        NSLog(@"Install info:");
        NSLog(@"Extra:%@",installInfo.extraDir);
        NSLog(@"Bootloader:%@",installInfo.bootfile);
        NSLog(@"Device node:%@",installInfo.deviceNode);
        NSLog(@"--------------------------------------------");	
        
        [delegate parametersSelectionComplete]; 
	} else NSLog(@"boot file or Extra dir not set");       
}

- (IBAction)deviceNodeSelected:(id)sender {
	int selectedDeviceIndex = [deviceNamePopUp indexOfSelectedItem];    	
	DeviceInformation * info = [deviceInformationArray objectAtIndex:selectedDeviceIndex];
	installInfo.deviceNode = info.deviceNode;	
    NSLog(@"Device set: %d %@",selectedDeviceIndex,installInfo.deviceNode);
}
- (void)alarmNoGUID {
	NSRunAlertPanel(@"There is no GUID_partition_scheme devices!", [NSString stringWithFormat:@"Format your device to GUID_partition_scheme and try again."], nil, nil, nil);
	[[NSApplication sharedApplication] terminate:self];
}
@end
